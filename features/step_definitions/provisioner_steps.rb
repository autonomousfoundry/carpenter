Given "a requirement" do
  @workspace.write "requirements.json", '[{"requirement": "sample_file_exists"}]'
end

Given "a verification for the requirement" do
  @workspace.write "requirements/sample_file_exists.rb", <<-END
    require 'fileutils'
    verify :sample_file_exists do |options|
      FileUtils.touch "sample.file"
    end
  END
end

When "I invoke the provisioner" do
  @workspace.chdir { `../bin/provision` }
end

Then "I should see that the verify step was run" do
  assert @workspace.exists? "sample.file"
end
