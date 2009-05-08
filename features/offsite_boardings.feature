Feature: Offsite Boardings
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as boarding somewhere else, like school

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Mark a Child as Boarding Offsite
    When I record an offsite boarding for "Ramadhan Masawe"
    Then I should see "Offsite Boarding recorded for Ramadhan Masawe."

  Scenario: A Child Who Isn't Boarding Offsite
    When I go to the offsite boardings children page
    Then I should not see "Ramadhan Masawe"

  Scenario: A Child Who Is Boarding Offsite
    When I record an offsite boarding for "Ramadhan Masawe"
    And I go to the offsite boardings children page
    Then I should see "Ramadhan Masawe"
