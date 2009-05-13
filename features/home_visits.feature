Feature: Home Visits
  In order to make sure we are following up well with our children
  As an Amani Caregiver
  I want to record the Home Visits I make

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Record a Home Visit
    When I record a home visit for "Ramadhan Masawe"
    Then I should see "Home Visit recorded for Ramadhan Masawe."
