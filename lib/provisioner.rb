require 'json'
require_relative 'carpenter'

class Provisioner
  def load_specifications(file)
    @requirement_specifications = JSON.parse File.read(file)
  end

  def load_requirements(path)
    Dir[path].each do |file_name|
      require file_name
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
      verifier = Carpenter::Provisioning.get_verifier(specification["requirement"])
      verifier.call specification["options"]
    end
  end
end
