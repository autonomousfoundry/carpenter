Feature: provision

  Scenario: verify
    Given a required ability
    And a verification for the ability
    When I invoke the provisioner
    Then I should see that the verify step was run

  @wip
  Scenario: An ability with no verification
    Given a required ability
    When I invoke the provisioner
    Then I should see that there was no verification for that ability

  @wip
  Scenario: An ability that fails verification, with no implementation
    Given a required ability
    And a verification for the ability that fails
    When I invoke the provisioner
    Then I should see that there was no implementation for that ability

  @wip
  Scenario: An ability that fails verification, with no implementation
    Given a required ability
    And a verification for the ability that requires a temp file
    And an implementation for the ability that creates the temp file
    When I invoke the provisioner
    Then I should see that the implementation was run
    And I should see that the provisioning is complete
    And the temp file should exist
