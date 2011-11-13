require 'json'
require_relative 'carpenter'

class Provisioner
  def load_specifications(file)
    @ability_specifications = JSON.parse File.read(file)
  end

  def load_abilities(path)
    Dir[path].each do |file_name|
      require file_name
    end
  end

  def load_strategies(path)
    Dir[path].each do |file_name|
      require file_name
    end
  end

  def find_ability(ability_name)
    self.class.const_get ability_name
  end

  def run
    @ability_specifications.each do |specification|
      verifier = Carpenter::Provisioning.get_verifier(specification["ability"])
      verifier.call specification["options"]
    end
  end
end
