Given "a requirement" do
  @workspace.write "requirements.json", '[{"requirement": "my_requirement"}]'
end

Given "a verification that fails" do
  @workspace.write "requirements/verify.rb", <<-END
    verify(:my_requirement) { |options| false }
  END
end

Given "a verification that checks for a temp file" do
  @workspace.write "requirements/verify.rb", <<-END
    verify(:my_requirement) { |options| File.exists? "temp_file" }
  END
end

Given "a plan that creates the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    build(:my_requirement) { |options| FileUtils.touch "temp_file" }
  END
end

When "I invoke the provisioner" do
  @workspace.chdir { @provisioner_output = `provision` }
end

Then "I should see that the verification was missing" do
  assert_match /No verification found/, @provisioner_output
end

Then "I should see that the plan was missing" do
  assert_match /No plan found/, @provisioner_output
end

Then "I should see that the provisioning succeeded" do
  assert_match /Provisioning complete/, @provisioner_output
end

Then "I should see that the verification failed" do
  assert_match /Verification failed/, @provisioner_output
end

Then "the temp file should exist" do
  assert @workspace.exists? "temp_file"
end
