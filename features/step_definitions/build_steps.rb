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

When "I invoke the build" do
  @workspace.chdir { @build_output = `carpenter` }
end

Then "show me the output" do
  puts @workspace.chdir { `carpenter` }
end

Then "I should see that the verification was missing" do
  assert_match /No verification found/, @build_output
end

Then "I should see that the plan was missing" do
  assert_match /No plan found/, @build_output
end

Then "I should see that the build succeeded" do
  assert_match /Build complete/, @build_output
end

Then "I should see that the verification failed" do
  assert_match /Verification failed/, @build_output
end

Then "the temp file should exist" do
  assert @workspace.exists? "temp_file"
end
