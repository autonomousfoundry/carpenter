module Carpenter
  class Validation < Command

    def valid?
      process_requirements
      true
    rescue
      puts $!
      false
    end

    def verify(name, options)
      verification(name) || raise("No verification found for '#{name}'")
      build(name, options)
    end

    def build(name, options)
      plan(name) || raise("No plan found for '#{name}'")
    end

  end
end
