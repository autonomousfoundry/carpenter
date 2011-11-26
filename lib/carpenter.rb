module Carpenter

  VERSION = "0.0.0"

  autoload :DefinitionCollection, "carpenter/definition_collection"
  autoload :Plan, "carpenter/plan"

  # commands
  autoload :Build, "carpenter/build" # add commands namespace? carpenter/commands/build.rb

end
