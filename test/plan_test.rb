require 'test/unit'

class PlanTest < Test::Unit::TestCase
  def test_plan_without_description
    @plan = Carpenter::Plan.new("a_plan"){}
    assert_equal "a_plan", @plan.description
  end

  def test_plan_with_description
    @plan = Carpenter::Plan.new("a_plan"){}
    @plan.description("A Plan with a description")
    assert_equal "A Plan with a description", @plan.description
  end

  def test_plan_description_allows_chaining
    @plan = Carpenter::Plan.new("a_plan"){}
    assert_equal @plan, @plan.description("A Plan with a description")
    assert_equal "A Plan with a description", @plan.description
  end

  def test_plan_without_requirements
    @plan = Carpenter::Plan.new("a_plan"){}
    assert_equal [], @plan.requirements
  end

  def test_plan_with_requirements
    @plan = Carpenter::Plan.new("a_plan"){}
    @plan.requirements([{:requirement => 'r1', :options => [1,2]},
                        {:requirement => 'r2', :options => [3,4]}])
    assert_equal({'requirement' => 'r1', 'options' => [1,2]}, @plan.requirements.first)
    assert_equal({'requirement' => 'r2', 'options' => [3,4]}, @plan.requirements.last)
  end

  def test_plan_requirements_allows_chaining
    @plan = Carpenter::Plan.new("a_plan"){}
    assert_equal @plan, @plan.requirements([{:requirement => 'r1'}])
    assert_equal [{'requirement' => 'r1'}], @plan.requirements
  end
end