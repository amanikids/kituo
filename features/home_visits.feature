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
    Given arrival for "Ramadhan Masawe" exists
    When I record a home visit for "Ramadhan Masawe"
    And I go to the onsite children page
    Then I should see "Ramadhan Masawe"

  Scenario: Children Without a Recorded Arrival Do Not Require a Home Visit
    When I go to the upcoming home visits tasks page
    Then I should not see "Ramadhan Masawe"

  Scenario: Children With a Recorded Arrival Do Require a Home Visit
    Given arrival for "Ramadhan Masawe" exists
    When I go to the upcoming home visits tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: Children With a Recorded Home Visit Do Not Require a Home Visit
    Given arrival for "Ramadhan Masawe" exists
    When I record a home visit for "Ramadhan Masawe"
    And I go to the upcoming home visits tasks page
    Then I should not see "Ramadhan Masawe"

  Scenario: Social Workers Show Home Visit Tasks for Their Children
    Given caregiver "Japhary Salum" exists
    And arrival for "Ramadhan Masawe" exists
    When I assign "Ramadhan Masawe" to "Japhary Salum"
    And I go to the caregiver page for "Japhary Salum"
    Then I should see "Make a Home Visit for Ramadhan Masawe"

  Scenario: Children Show Their Own Home Visit Tasks
    Given arrival for "Ramadhan Masawe" exists
    When I go to the child page for "Ramadhan Masawe"
    Then I should see "Make a Home Visit for Ramadhan Masawe"

  Scenario: Deleting a Home Visit
    Given arrival for "Ramadhan Masawe" exists
    And home visit for "Ramadhan Masawe" exists
    When I delete a home visit for "Ramadhan Masawe"
    And I go to the upcoming home visits tasks page
    Then I should see "Ramadhan Masawe"
