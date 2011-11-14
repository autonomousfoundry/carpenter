Feature: verify

  Scenario: verify
    Given a required ability
    And a verification for the ability
    When I invoke the verify operation
    Then I should see that the verify step was run
