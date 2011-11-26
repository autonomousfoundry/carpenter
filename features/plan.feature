Feature: Plan

  Scenario: A plan without a description shows the plan name on failure
    Given a requirement
    And a verification that checks for a temp file
    And a plan that fails to create the temp file
    When I invoke the build
    Then I should see the plan name

  Scenario: A plan with a description shows that description on failure
    Given a requirement
    And a verification that checks for a temp file
    And a plan with a description that fails to create the temp file
    When I invoke the build
    Then I should see the plan description
