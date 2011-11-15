require 'json'

class Provisioner
  def load_specifications(file)
    @requirement_specifications = JSON.parse File.read(file)
    @verifiers = {}
  end

  def load_requirements(path)
    Dir[path].each do |file_name|
      instance_eval File.read(file_name)
    end
  end

  def load_strategies(path)
    Dir[path].each do |file_name|
      require file_name
    end
  end

  def find_requirement(requirement_name)
    self.class.const_get requirement_name
  end

  def run
    @requirement_specifications.each do |specification|
      verifier = @verifiers[specification["requirement"]]
      verifier.call specification["options"]
    end
  end

  def verify(ability_name, &block)
    @verifiers[ability_name.to_s] = block
  end
end
