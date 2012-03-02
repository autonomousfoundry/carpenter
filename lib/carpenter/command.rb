module Carpenter
  class Command

    def initialize(requirements, verifications={}, plans={})
      @requirements, @verifications, @plans = requirements, verifications, plans
    end

    def succeeded(messages=nil)
      puts Array(messages).join("\n") unless messages.nil?
      @succeeded = true
    end

    def succeeded?
      @succeeded != false
    end

    def failed(messages=nil)
      puts Array(messages).join("\n") unless messages.nil?
      @succeeded = false
    end

    def process_requirements
      @requirements.each do |requirement|
        process_requirement(requirement["requirement"], requirement["options"])
      end
    end

    def process_requirement(name, options)
      unless verify(name, options)
        prerequisites(name)
        build(name, options)
        verify(name, options) || verification_failed(name)
      end
    rescue => exception
      handle_exception(exception)
    end

    def handle_exception(exception)
      raise exception
    end

    def plan_requirements(name)
      p = plan(name)
      Array(p && p.requirements)
    end

    def prerequisites(name)
      plan_requirements(name).each do |requirement|
        process_requirement requirement["requirement"], requirement["options"]
      end
    end

    def verify_prerequisites(name)
      plan_requirements(name).each do |requirement|
        verify(requirement["requirement"], requirement["options"]) or return false
      end
      true
    end

    def verification_failed(name)
      raise("Verification failed for '#{plan(name).description}'")
    end

    def verify(name, options)
      if verification(name)
        verification(name).call(options)
      else
        verify_prerequisites(name)
      end
    end

    def build(name, options)
      plan(name) && plan(name).call(options)
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
