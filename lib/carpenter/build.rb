module Carpenter
  class Build

    def initialize(specifications, requirements={}, plans={})
      @specifications, @requirements, @plans = specifications, requirements, plans
    end

    def run
      @specifications.each do |specification|
        name = specification["requirement"]
        options = specification["options"]
        verifier = @requirements[name]
        raise "No verification found for '#{name}'" unless verifier
        unless verifier.call options
          plan = @plans[name]
          raise "No plan found for '#{name}'" unless plan
          plan.call options
          raise "Verification failed for '#{plan.description}'" unless verifier.call options
        end
      end
      puts "Build complete."
    rescue
      puts $!
    end

  end
end
