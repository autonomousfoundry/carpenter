Feature: build

  Scenario: A requirement with no verification
    Given a requirement
    When I invoke the build
    Then I should see that the verification was missing

  Scenario: A requirement that fails verification, with no plan
    Given a requirement
    And a verification that fails
    When I invoke the build
    Then I should see that the plan was missing

  Scenario: A requirement and corresponding plan
    Given a requirement
    And a verification that checks for a temp file
    And a plan that creates the temp file
    When I invoke the build
    And I should see that the build succeeded
    And the temp file should exist

  Scenario: Verification is run again after building
    Given a requirement
    And a verification that fails
    And a plan that creates the temp file
    When I invoke the build
    Then I should see that the verification failed