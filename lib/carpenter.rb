module Carpenter

  VERSION = "0.0.0"

  autoload :DefinitionCollection, "carpenter/definition_collection"
  autoload :Plan, "carpenter/plan"

  # commands
  autoload :Command,    "carpenter/command"
  autoload :Build,      "carpenter/build"
  autoload :Validation, "carpenter/validation"
  autoload :Tree,       "carpenter/tree"

end
