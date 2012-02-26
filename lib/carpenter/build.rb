module Carpenter
  class Build < Command

    def run
      if (validation = Validation.new(@requirements, @verifications, @plans)).valid?
        process_requirements
        succeeded "Build complete."
      else
        failed validation.errors
      end
    rescue
      failed $!
    end

  end
end
