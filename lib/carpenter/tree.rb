require 'builder'

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

    def to_xml
      @builder = Builder::XmlMarkup.new :indent => 2
      process_requirements
      @builder.target!
    end

    def to_tree
      @builder = Builder::XmlMarkup.new :indent => 2
      TagLess.send :extend_object, @builder
      process_requirements
      @builder.target!
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
