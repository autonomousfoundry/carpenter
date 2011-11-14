Given "a configuration file that requires an ability" do
  File.open File.join(@workspace, "abilities.json"), "w" do |f|
    f.puts '[{"ability": "sample_file_exists", "options": {"version": 1}}]'
  end
end

Given "a definition file that verifies the ability" do
  Dir.mkdir File.join(@workspace, "abilities")
  File.open File.join(@workspace, "abilities", "sample_file_exists.rb"), "w" do |f|
    f.puts <<END
require 'fileutils'
class SampleFileExists
  extend Carpenter::Provisioning
  verify :sample_file_exists do |options|
    FileUtils.touch "sample.file"
  end
end
END
  end
end

When "I invoke the verify operation" do
  Dir.chdir @workspace do
    `../bin/provision`
  end
end

Then "I should see that the verify step was run" do
  assert File.exists? File.join(@workspace, "sample.file")
end
