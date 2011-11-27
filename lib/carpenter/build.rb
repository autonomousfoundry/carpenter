module Carpenter
  class Build < Command

    def run
      if Validation.new(@requirements, @verifications, @plans).valid?
        process_requirements
        puts "Build complete."
      end
    rescue
      puts $!
    end

    def verify(name, options)
      verification(name).call(options)
    end

    def build(name, options)
      plan(name).call(options)
      true
    end

  end
end
