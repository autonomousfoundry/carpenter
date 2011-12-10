module Carpenter
  class Plan

    attr_accessor :name, :requirements, :build

    def initialize(name, &block)
      @name = name
      @build = block if block_given?
    end

    def description(update=nil)
      if update
        @description = update
        return self
      end
      @description || name
    end

    def requirements(update=nil)
      if update
        # equivalent to stringify_keys!
        @requirements = update.map{|hash| hash.keys.each{|k| hash[k.to_s] = hash.delete(k) }; hash }
        return self
      end
      @requirements || []
    end

    def call(*args, &block)
      @build.call *args, &block
    end

  end
end
