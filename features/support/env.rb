Before do
  @workspace = CucumberWorkspace.new("cucumber_temp")
end

After do |scenario|
  @workspace.clear unless scenario.failed?
end

World Test::Unit::Assertions
