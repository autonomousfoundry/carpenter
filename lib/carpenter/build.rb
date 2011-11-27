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

  end
end
