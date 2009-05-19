Feature: Caregivers
  In order to see which Social Worker is responsible for each child
  As a Social Work Coordinator
  I want to enter Caregivers into the system

  Scenario: I Save a New Caregiver
    When I try to create a caregiver named "Japhary Salum"
    Then I should see "Created caregiver Japhary Salum."

  Scenario: I Try to Save a Caregiver Without a Name
    When I try to create a caregiver named ""
    Then I should see "can't be blank"
