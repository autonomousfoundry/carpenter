require 'test/unit'

class DefinitionCollectionTest < Test::Unit::TestCase
  def setup
    @definition_collection = Carpenter::DefinitionCollection.new
  end

  def test_plan_block_creates_a_plan
    @definition_collection.plan("my_requirement"){}
    assert_equal Carpenter::Plan, @definition_collection.plans["my_requirement"].class
  end

  def test_plan_options_populate_the_plan
    @definition_collection.plan("my_requirement") do
      @definition_collection.description "The Description"
      @definition_collection.build { "the build result" }
      @definition_collection.requires [{"the"=>"requirements"}]
    end
    plan = @definition_collection.plans["my_requirement"]
    assert_equal "The Description", plan.description
    assert_equal "the build result", plan.build.call
    assert_equal [{"the"=>"requirements"}], plan.requirements
  end

  def test_requirement_block_adds_a_verifier
    @definition_collection.requirement("my_requirement") do
      @definition_collection.verify { "the verify result" }
    end
    verification = @definition_collection.verifications["my_requirement"]
    assert_equal "the verify result", verification.call
  end

end
