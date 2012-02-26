module Carpenter
  class Build < Command

    def run
      if Validation.new(@requirements, @verifications, @plans).valid?
        process_requirements
        succeeded "Build complete."
      end
    rescue
      failed $!
    end

  end
end
