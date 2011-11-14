Before do
  @workspace = "cucumber_temp"
  FileUtils.mkdir_p @workspace
  FileUtils.rm_r @workspace, :secure => true
  FileUtils.mkdir_p @workspace
end

After do |scenario|
  FileUtils.rm_r @workspace, :secure => true unless scenario.failed?
end

World Test::Unit::Assertions
