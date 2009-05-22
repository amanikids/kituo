Feature: Case Assignments
  In order to help us follow up with children more carefully
  As an Amani Caregiver
  I want to know who's responsible for each child

  Background:
    Given child "Ramadhan Masawe" exists
    And caregiver "Japhary Salum" exists

  Scenario: I Assign a Child to a Social Worker
    When I assign "Ramadhan Masawe" to "Japhary Salum"
    Then I should see "Ramadhan Masawe's social worker is now Japhary Salum."

  Scenario: Assigning a Child to a Social Worker Puts Him on the Social Worker's page
    When I assign "Ramadhan Masawe" to "Japhary Salum"
    And I go to the caregiver page for "Japhary Salum"
    Then I should see "Ramadhan Masawe"

  # Tasks
  # Top-level
  Scenario: Children without a Social Worker show up on the Unassigned Children page
    When I go to the unassigned children tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: Assigning a Child to a Social Worker Takes Him off the Unassigned Children page
    When I assign "Ramadhan Masawe" to "Japhary Salum"
    And I go to the unassigned children tasks page
    Then I should not see "Ramadhan Masawe"

  # Child
  Scenario: Children show their "I Need a Social Worker" tasks
    When I go to the child page for "Ramadhan Masawe"
    Then I should see "Assign Ramadhan Masawe to a Social Worker"
