module Carpenter
  class Validation < Command

    attr_accessor :errors

    def valid?
      @errors = []
      process_requirements
      @errors.empty?
    end

    def verify(name, options)
      if plan_requirements(name).empty? && verification(name).nil?
        add_error "No verification found for '#{name}'"
      end
      false
    end

    def build(name, options)
      plan(name) || add_error("No plan found for '#{name}'")
      if (plan(name) && plan(name).build.nil?) && plan_requirements(name).empty?
        add_error("Plan '#{name}' needs 'build' or 'requirements'")
      end
    end

    def verification_failed(name)
    end

    def handle_exception(exception)
      add_error exception.message
    end

    def add_error(error)
      @errors |= [error]
    end

  end
end
