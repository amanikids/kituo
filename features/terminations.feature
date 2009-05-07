Feature: Terminations
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as terminated

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Mark a Child as Terminated
    When I record a termination for "Ramadhan Masawe"
    Then I should see "Termination recorded for Ramadhan Masawe."

  Scenario: A Child Who Hasn't Been Terminated
    When I go to the terminated children page
    Then I should not see "Ramadhan Masawe"

  Scenario: A Child Who Has Been Terminated
    When I record a termination for "Ramadhan Masawe"
    And I go to the terminated children page
    Then I should see "Ramadhan Masawe"


