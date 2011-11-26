module Carpenter
  class Plan

    attr_accessor :name

    def initialize(name, &block)
      @name, @build = name.to_s, block
    end

    def description(update=nil)
      if update
        @description = update
        return self
      end
      @description || name
    end

    def call(*args, &block)
      @build.call *args, &block
    end

  end
end
