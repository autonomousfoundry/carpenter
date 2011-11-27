module Carpenter
  class Command

    def initialize(requirements, verifications={}, plans={})
      @requirements, @verifications, @plans = requirements, verifications, plans
    end

    def process_requirements
      @requirements.each do |requirement|
        process_requirement(requirement["requirement"], requirement["options"])
      end
    end

    def process_requirement(name, options)
      unless verify(name, options)
        prerequisites name
        build(name, options)
        verify(name, options) || verification_failed(name)
      end
    end

    def prerequisites(name)
      plan = plan(name)
      if plan && plan.requirements.size > 0
        plan.requirements.each do |requirement|
          process_requirement requirement["requirement"], requirement["options"]
        end
      end
    end

    def verification_failed(name)
      raise("Verification failed for '#{plan(name).description}'")
    end

    def verify(name, options)
      verification(name).call(options)
    end

    def build(name, options)
      plan(name).call(options)
      true
    end

    def verification(name)
      @verifications[name]
    end

    def plan(name)
      @plans[name]
    end

  end
end
