Feature: Arrivals
  In order to get a child on the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having arrived

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Mark a Child as Arrived
    When I record an arrival for "Ramadhan Masawe"
    Then I should see "Arrival at Amani recorded for Ramadhan Masawe."

  Scenario: A Child Who Hasn't Arrived
    When I go to the onsite children page
    Then I should not see "Ramadhan Masawe"

  Scenario: A Child Who Has Arrived
    When I record an arrival for "Ramadhan Masawe"
    When I go to the onsite children page
    Then I should see "Ramadhan Masawe"
