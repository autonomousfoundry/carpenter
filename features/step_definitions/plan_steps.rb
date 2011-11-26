Given "a plan that fails to create the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    build(:my_requirement) { |options|  }
  END
end

Given "a plan with a description that fails to create the temp file" do
  @workspace.write "requirements/plan.rb", <<-END
    require 'fileutils'
    build(:my_requirement){}.description("My Requirement Description")
  END
end

Then %{I should see the plan description} do
  assert_match /My Requirement Description/, @build_output
end

Then %{I should see the plan name} do
  assert_match /my_requirement/, @build_output
end

