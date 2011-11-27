module Carpenter
  class Tree < Command

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

    def output(format=nil)
      @builder = format.to_s == 'xml' ? xml_builder : tree_builder
      process_requirements
      @builder.target!
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

    def process_requirement(name, options, builder=@builder)
      plan = plan(name)
      builder.tag!('requirement') do |b|
        b.tag! 'name', name
        b.tag! "options", options unless options.nil?
        b.tag! "plan", plan.description if plan
        if plan && plan.requirements.size > 0
          b.prerequisites do |p|
            plan.requirements.each do |requirement|
              process_requirement requirement["requirement"], requirement["options"], p
            end
          end
        end
      end
    end

  end
end
