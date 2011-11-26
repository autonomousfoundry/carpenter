require 'json'

module Carpenter
  class DefinitionCollection

    attr_accessor :specifications, :requirements, :plans

    def initialize
      @plans = {}
      @requirements = {}
      @specifications = []
    end

    def load_specifications(file)
      @specifications = JSON.parse File.read(file)
    end

    def load_definitions(path)
      Dir[path].each do |file_name|
        instance_eval File.read(file_name)
      end
    end

    def verify(ability_name, &block)
      @requirements[ability_name.to_s] = block
    end

    def build(ability_name, options={}, &block)
      plan = Plan.new ability_name, &block
      if options
        plan.description options[:description] || options['description']
      end
      @plans[plan.name] = plan
    end
  end
end
