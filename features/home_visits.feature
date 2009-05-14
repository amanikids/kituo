Feature: Home Visits
  In order to make sure we are following up well with our children
  As an Amani Caregiver
  I want to record the Home Visits I make

  Background:
    Given child "Ramadhan Masawe" exists

  Scenario: I Record a Home Visit
    When I record a home visit for "Ramadhan Masawe"
    Then I should see "Home Visit recorded for Ramadhan Masawe."

  Scenario: Recording a Home Visit for a Child at Amani Should Keep Them on the Onsite Children Page
    When I record an arrival for "Ramadhan Masawe" on "January 13, 2006"
    And I record a home visit for "Ramadhan Masawe"
    And I go to the onsite children page
    Then I should see "Ramadhan Masawe"

  Scenario: Children Without a Recorded Arrival Do Not Require a Home Visit
    When I go to the upcoming home visits tasks page
    Then I should not see "Ramadhan Masawe"

  Scenario: Arrived Children Do Require a Home Visit
    When I record an arrival for "Ramadhan Masawe" on "January 13, 2006"
    And I go to the upcoming home visits tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: Visited Children Do Not Require a Home Visit
    When I record an arrival for "Ramadhan Masawe" on "January 13, 2006"
    And I record a home visit for "Ramadhan Masawe"
    And I go to the upcoming home visits tasks page
    Then I should not see "Ramadhan Masawe"
