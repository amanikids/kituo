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

  Scenario: Deleting an Arrival
    Given arrival for "Ramadhan Masawe" exists
    When I delete an arrival for "Ramadhan Masawe"
    When I go to the onsite children page
    Then I should not see "Ramadhan Masawe"

  # Tasks
  # Top-level
  Scenario: New Children Show Up on the Unrecorded Arrivals Page
    When I go to the tasks page
    Then I should see an unrecorded arrival task for "Ramadhan Masawe"

  Scenario: Children with Arrivals should not Show Up on the Unrecorded Arrivals Page
    Given arrival for "Ramadhan Masawe" exists
    When I go to the tasks page
    Then I should not see an unrecorded arrival task for "Ramadhan Masawe"

  # Social Worker
  Scenario: Social Workers show Unrecorded Arrivals for their Children
    Given caregiver "Japhary Salum" exists
    When I assign "Ramadhan Masawe" to "Japhary Salum"
    And I go to the caregiver page for "Japhary Salum"
    Then I should see an unrecorded arrival task for "Ramadhan Masawe"

  # Child
  Scenario: Children show their own Unrecorded Arrivals
    When I go to the child page for "Ramadhan Masawe"
    Then I should see an unrecorded arrival task for "Ramadhan Masawe"
