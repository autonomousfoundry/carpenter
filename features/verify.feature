Feature: Verify

  As a carpenter user
  I want to verify my plans & requirements
  In order to see verifications without running the build steps

  Scenario: A requirement with a failing verificaion
    Given a requirement
    And a plan that creates the temp file
    And a verification that fails
    When I invoke verify
    Then I should see the tree with a failed verification

  Scenario: A requirement with a passing verificaion
    Given a requirement
    And a plan
    And a verification that passes
    When I invoke verify
    Then I should see the tree with a passed verification

