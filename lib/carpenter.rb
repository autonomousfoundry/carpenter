module Carpenter
  module Provisioning

    @@verifiers = {}

    def verify(ability_name, &block)
      @@verifiers[ability_name.to_s] = block
    end

    def self.get_verifier(ability_name)
      @@verifiers[ability_name.to_s]
    end

  end
end
