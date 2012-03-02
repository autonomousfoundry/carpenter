Given "a requirement" do
  @workspace.write "requirements.json", '[{"requirement": "my_requirement"}]'
end

Given "a requirement in an alternate file" do
  @workspace.write "alternate_requirements.json", '[{"requirement": "my_requirement"}]'
end

Given "a verification that fails" do
  @workspace.write "requirements/verify.rb", <<-END
    requirement(:my_requirement){ verify{ |options| false } }
  END
end

Given "a verification in an alternate folder that fails" do
  @workspace.write "other_definitions/verify.rb", <<-END
    requirement(:my_requirement){ verify{ |options| false } }
  END
end

Given "a verification that checks for a temp file" do
  @workspace.write "requirements/verify.rb", <<-END
    requirement(:my_requirement){ verify{ |options| File.exists? "temp_file" } }
  END
end

Given "a plan that creates the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    plan(:my_requirement){ build{ FileUtils.touch "temp_file" } }
  END
end

When "I invoke the build" do
  step %{I capture the result of the command "carpenter"}
end

When "I invoke the build with an alternate file" do
  step %{I capture the result of the command "carpenter --requirements=alternate_requirements.json"}
end

When "I invoke the build with an alternate directory" do
  step %{I capture the result of the command "carpenter --definitions=other_definitions/**/*.rb"}
end

When %r!I capture the result of the command "([^"]*)"! do |command|
  @workspace.chdir do
    @command_output = `#{command}`
    @command_status = $?.exitstatus
  end
end

Then "show me the output" do
  puts @command_output
end

Then "I should see that the verification was missing" do
  assert_match /No verification found/, @command_output
  assert_equal 1, @command_status
end

Then "I should see that the plan was missing" do
  assert_match /No plan found/, @command_output
  assert_equal 1, @command_status
end

Then "I should see that the build succeeded" do
  assert_match /Build complete./, @command_output
  assert_equal 0, @command_status
end

Then "I should see that the verification failed" do
  assert_match /Verification failed/, @command_output
  assert_equal 1, @command_status
end

Then "the temp file should exist" do
  assert @workspace.exists? "temp_file"
end
