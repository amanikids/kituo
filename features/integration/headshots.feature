Feature: Headshots
  In order to visually identify people in the system
  As an Amani Caregiver
  I want children and caregivers to have headshots

  Scenario: Adding a new headshot for a Caregiver
    Given caregiver "Japhary Salum" exists
    And I am on the caregiver page for "Japhary Salum"
    When I follow "Edit Headshot"
    And I attach the file "sample_headshot.jpg" to "Upload a New Image"
    And I press "Save"
    Then I should see "Updated Headshot for Japhary Salum."

  Scenario: Adding a new headshot for a Child
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Edit Headshot"
    And I attach the file "sample_headshot.jpg" to "Upload a New Image"
    And I press "Save"
    Then I should see "Updated Headshot for Ramadhan Masawe."


