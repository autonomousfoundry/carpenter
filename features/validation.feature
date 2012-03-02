Feature: Validation

  As a carpenter user
  I want to see validation errors
  In order to save development time

  Scenario: A requirement with a verification and a plan
    Given a requirement
    And a verification
    And a plan
    When I invoke the build
    Then I should not see the error "No verification found"
    And I should not see the error "No plan found"
    And I should see that the build succeeded

  Scenario: A requirement without a verification
    Given a requirement
    When I invoke the build
    Then I should see the error "No verification found for 'my_requirement'"

  Scenario: A requirement without a plan
    Given a requirement
    When I invoke the build
    Then I should see the error "No plan found for 'my_requirement'"

  Scenario: A requirement without a verification, with a plan that has another requirement
    Given a requirement
    And a plan that has another requirement
    And the other requirement has a plan
    When I invoke the build
    Then I should see that the build succeeded

  Scenario: A requirement without a verification, with a plan that has another requirement but no plan
    Given a requirement
    And a plan that has another requirement
    When I invoke the build
    Then I should see the error "No plan found for 'other_requirement'"

  Scenario: A requirement without a build or requirements
    Given a requirement
    And a plan without a build or requirements
    When I invoke the build
    Then I should see the error "Plan 'my_requirement' needs 'build' or 'requirements'"

