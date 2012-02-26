require File.expand_path("../lib/carpenter", __FILE__)

Gem::Specification.new do |s|
  s.name        = "carpenter"
  s.version     = Carpenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian Auton", "Andrew Briening"]
  s.email       = ["brianauton+carpenter@gmail.com", "abriening+carpenter@gmail.com"]
  s.homepage    = "http://github.com/autonomousfoundry/carpenter"
  s.summary     = "A tool for automated system provisioning, configuration and maintenance."
  s.description = "A tool for automated system provisioning, configuration and maintenance."

  s.required_rubygems_version = ">= 1.3.6"

  # s.rubyforge_project         = "carpenter"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"
  s.add_dependency "json", "1.6.1"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  s.executables = ["carpenter"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end
