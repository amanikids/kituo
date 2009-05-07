Feature: Reunifications
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having been reunified

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Mark a Child as Reunified
    When I record a reunification for "Ramadhan Masawe"
    Then I should see "Family Reunification recorded for Ramadhan Masawe."

  Scenario: A Child Who Hasn't Been Reunified
    When I go to the reunified children page
    Then I should not see "Ramadhan Masawe"

  Scenario: A Child Who Hasn't Been Reunified
    When I record a reunification for "Ramadhan Masawe"
    And I go to the reunified children page
    Then I should see "Ramadhan Masawe"
