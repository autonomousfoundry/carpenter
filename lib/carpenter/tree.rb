module Carpenter
  class Tree < Command

    attr_accessor :verifier

    module TagLess
      def _start_tag(sym, attrs, end_too=false)
        @target << "#{sym}: "
      end

      def _end_tag(sym)
      end

      def target!
        @target.gsub(/^ *\n|^ *\Z/,'')
      end
    end

    def xml_builder
      require 'builder'
      Builder::XmlMarkup.new :indent => 2
    rescue LoadError
      raise "Can't load builder, gem install builder"
    end

    def tree_builder
      TagLess.send :extend_object, xml_builder
    end

    def current_builder
      @builders.last
    end

    def with_builder(builder)
      @builders ||= []
      @builders << builder
      yield
    ensure
      @builders.pop
    end

    def output(format=nil)
      with_builder format.to_s == 'xml' ? xml_builder : tree_builder do
        process_requirements
        current_builder.target!
      end
    rescue
      puts $!
    end

    def process_requirements
      if Validation.new(@requirements, @verifications, @plans).valid?
        super
      else
        puts "Tree is invalid."
      end
    end

    def process_requirement(name, options)
      plan = plan(name)
      current_builder.tag!('requirement') do |b|
        with_builder b do
          current_builder.tag! 'name', name
          current_builder.tag! "options", options unless options.nil?
          current_builder.tag! "plan", plan.description if plan
          if verifier
            current_builder.tag! "verification", verify(name, options).inspect
          end
          if plan && plan.requirements.size > 0
            current_builder.prerequisites do |p|
              with_builder p do
                plan.requirements.each do |requirement|
                  process_requirement requirement["requirement"], requirement["options"]
                end
              end
            end
          end
        end
      end
    end

  end
end
