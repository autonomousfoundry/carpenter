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
end