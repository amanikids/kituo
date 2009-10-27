Feature: Caregivers
  In order to personalize the system for my needs
  As an Amani caregiver
  I want it to know who I am

  Scenario: New Caregiver
    Given I am on the english dashboard
    When I click "Introduce yourself"
    And I fill in "Name" with "Matthew Todd"
    And I select "Social Worker" from "Role"
    And I press "Save"
    Then I should see "Welcome, Matthew!"

  Scenario: Editing my profile as a Social Worker
    Given the following users exist:
      | Role          | Name            |
      | Social Worker | Godfrey Pamphil |
    And I am signed in as "Godfrey Pamphil"
    When I click "Edit your profile"
    And I fill in "Name" with "Japhary Salum"
    And I select "Social Work Coordinator" from "Role"
    And I attach the file "sample_headshot.jpg" to "Headshot"
    And I press "Save"
    Then I should see "Welcome, Japhary!"
    And I should see "Length of Stay at Amani"
    And there should be a headshot "sample_headshot.jpg" for caregiver "Japhary Salum"

  Scenario: Editing my profile as a Social Work Coordinator
    Given the following users exist:
      | Role                    | Name          |
      | Social Work Coordinator | Japhary Salum |
    And I am signed in as "Japhary Salum"
    When I click "Edit your profile"
    Then I should see "Edit your profile"

  Scenario: Editing my profile as a Development Officer
    Given the following users exist:
      | Role                | Name        |
      | Development Officer | Joe Ventura |
    And I am signed in as "Joe Ventura"
    When I click "Edit your profile"
    Then I should see "Edit your profile"
