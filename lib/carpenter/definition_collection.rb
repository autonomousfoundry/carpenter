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
        instance_eval File.read(file_name), file_name, 0
      end
    end

    def requirement(requirement_name)
      @current_requirement_name = requirement_name.to_s
      yield
      @current_requirement_name = nil
    end

    def plan(requirement_name)
      @current_plan = Plan.new requirement_name
      yield
      @plans[requirement_name.to_s] = @current_plan
      @current_plan = nil
    end

    def verify(&block)
      @verifications[@current_requirement_name] = block
    end

    def build(&block)
      @current_plan.build = block
    end

    def description(text)
      @current_plan.description text
    end

    def requires(requirements_array)
      @current_plan.requirements requirements_array
    end
  end
end
