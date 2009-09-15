Feature: Caregivers
  In order to see which Social Worker is responsible for each child
  As a Social Work Coordinator
  I want to enter Caregivers into the system

  Scenario: I Save a New Caregiver
    When I create a caregiver named "Japhary Salum"
    Then I should see "Created caregiver Japhary Salum."

  Scenario: I Try to Save a Caregiver Without a Name
    When I create a caregiver named ""
    Then I should see "can't be blank"

  Scenario: I Edit a Caregiver's Name
    Given caregiver "Japhary Salum" exists
    When I go to the caregiver page for "Japhary Salum"
    And I follow "Edit Name"
    And I fill in "Name" with "Jafari Saloom"
    And I press "Save"
    Then I should see "Updated caregiver Jafari Saloom."
    And I should not see "Japhary Salum"

  Scenario: I Edit a Caregiver's Name, Setting It to Blank
    Given caregiver "Japhary Salum" exists
    When I go to the caregiver page for "Japhary Salum"
    And I follow "Edit Name"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "can't be blank"
    And I should see "Japhary Salum"
