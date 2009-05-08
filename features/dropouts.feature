Feature: Dropouts
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having dropped out

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Mark a Child as Dropped Out
    When I record a dropout for "Ramadhan Masawe"
    Then I should see "Dropout recorded for Ramadhan Masawe."

  Scenario: A Child Who Hasn't Dropped Out
    When I go to the dropouts children page
    Then I should not see "Ramadhan Masawe"

  Scenario: A Child Who Has Dropped Out
    When I record a dropout for "Ramadhan Masawe"
    And I go to the dropouts children page
    Then I should see "Ramadhan Masawe"
