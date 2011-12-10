Given "a plan that fails to create the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    plan(:my_requirement){ build {} }
  END
end

Given "a plan with a description that fails to create the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    plan(:my_requirement){ build{}; description("My Requirement Description") }
  END
end

Given "a plan that requires a plan that fails" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    plan(:my_requirement){ requires [{"requirement" => "other_requirement"}] }
  END
  @workspace.write "requirements/other_verification.rb", <<-END
    requirement(:other_requirement){ verify { |options| false } }
    plan(:other_requirement){ build {} }
  END
end

Then %{I should see the required plan name} do
  assert_match /other_requirement/, @build_output
end

Then %{I should see the plan description} do
  assert_match /My Requirement Description/, @build_output
end

Then %{I should see the plan name} do
  assert_match /my_requirement/, @build_output
end

