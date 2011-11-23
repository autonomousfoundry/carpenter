require 'json'

module Carpenter
  class Build

    def load_specifications(file)
      @specifications = JSON.parse File.read(file)
      @verifiers = {}
      @plans = {}
    end

    def load_definitions(path)
      Dir[path].each do |file_name|
        instance_eval File.read(file_name)
      end
    end

    def run
      @specifications.each do |specification|
        name = specification["requirement"]
        options = specification["options"]
        verifier = @verifiers[name]
        raise "No verification found for '#{name}'" unless verifier
        unless verifier.call options
          plan = @plans[name]
          raise "No plan found for '#{name}'" unless plan
          plan.call options
          raise "Verification failed for '#{name}'" unless verifier.call options
        end
      end
      puts "Build complete."
    rescue
      puts $!
    end

    def verify(ability_name, &block)
      @verifiers[ability_name.to_s] = block
    end

    def build(ability_name, &block)
      @plans[ability_name.to_s] = block
    end
  end
end
