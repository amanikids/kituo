Feature: Caregivers
  In order to personalize the system for my needs
  As an Amani caregiver
  I want it to know who I am

  Scenario: New Caregiver
    Given I am on the english dashboard
    When I click "Introduce yourself"
    And I fill in "name" with "Matthew Todd"
    And I select "Social Worker" from "role"
    And I press "Save"
    Then I should see "Welcome, Matthew!"
