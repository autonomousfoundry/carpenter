require 'json'

module Carpenter
  class DefinitionCollection

    attr_accessor :requirements, :verifications, :plans

    def initialize
      @plans = {}
      @verifications = {}
      @requirements = []
    end

    def load_requirements(file)
      @requirements = JSON.parse File.read(file)
    end

    def load_definitions(path)
      Dir[path].each do |file_name|
        instance_eval File.read(file_name)
      end
    end

    def verify(ability_name, &block)
      @verifications[ability_name.to_s] = block
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
