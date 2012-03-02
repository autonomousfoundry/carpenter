When "I invoke verify" do
  step %{I capture the result of the command "carpenter verify"}
end

Then %r!I should see the error "([^"]*)"! do |error|
  assert_match Regexp.new(error), @command_output
  assert_equal 1, @command_status, @command_output
end

Then %r!I should not see the error "([^"]*)"! do |error|
  assert_no_match Regexp.new(error), @command_output
  assert_equal 0, @command_status, @command_output
end

Then "I should see the tree with a failed verification" do
  assert_match %r!plan: my_requirement\n  verification: false!, @command_output
  assert_equal 1, @command_status, @command_output
end

Then "I should see the tree with a passed verification" do
  assert_match %r!plan: my_requirement\n  verification: true!, @command_output
  assert_equal 0, @command_status, @command_output
end

Given "a plan" do
  step "a plan that creates the temp file"
end

Given "a verification" do
  step "a verification that passes"
end

Given "a verification that passes" do
  @workspace.write "requirements/verify.rb", <<-END
    requirement(:my_requirement){ verify{ true } }
  END
end

Given "a plan that has another requirement" do
  @workspace.write "requirements/plan.rb", <<-END
    plan(:my_requirement){ requires [{"requirement" => "other_requirement"}] }
  END
  @workspace.write "requirements/verification.rb", <<-END
    requirement(:other_requirement){ verify { |options| true } }
  END
end

Given "the other requirement has a plan" do
  @workspace.write "requirements/other_plan.rb", <<-END
    plan(:other_requirement){ build{} }
  END
end

Given "a plan without a build or requirements" do
  @workspace.write "requirements/plan.rb", <<-END
    plan(:my_requirement){ }
  END
end
