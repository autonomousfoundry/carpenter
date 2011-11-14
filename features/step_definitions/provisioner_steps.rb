Given "a required ability" do
  @workspace.write "abilities.json", '[{"ability": "sample_file_exists"}]'
end

Given "a verification for the ability" do
  @workspace.write "abilities/sample_file_exists.rb", <<END
require 'fileutils'
class SampleFileExists
  extend Carpenter::Provisioning
  verify :sample_file_exists do |options|
    FileUtils.touch "sample.file"
  end
end
END
end

When "I invoke the provisioner" do
  @workspace.chdir { `../bin/provision` }
end

Then "I should see that the verify step was run" do
  assert @workspace.exists? "sample.file"
end
