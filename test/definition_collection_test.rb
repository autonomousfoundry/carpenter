require 'test/unit'

class DefinitionCollectionTest < Test::Unit::TestCase
  def setup
    @definition_collection = Carpenter::DefinitionCollection.new
  end

  def test_build_returns_plan_instance
    @plan = @definition_collection.build("a_plan"){}
    assert_equal Carpenter::Plan, @plan.class
  end

  def test_build_with_description_option
    @plan = @definition_collection.build("a_plan", :description => "A Plan with a description"){}
    assert_equal "A Plan with a description", @plan.description
  end

  def test_build_with_requirements_option
    @plan = @definition_collection.build("a_plan", :requirements => [{'requirement' => 'r1'}]){}
    assert_equal [{'requirement' => 'r1'}], @plan.requirements
  end
end
