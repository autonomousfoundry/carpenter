Feature: verify

  Scenario: verify
    Given a configuration file that requires an ability
    And a definition file that verifies the ability
    When I invoke the verify operation
    Then I should see that the verify step was run
