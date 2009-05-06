Feature: Headshots
  In order to visually identify a child in the system
  As a Amani Caregiver
  I want children to have headshots

  Scenario: Adding a new headshot
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Edit Headshot"
    And I attach the file at "features/support/sample_headshot.jpg" to "Upload a New Image"
    And I press "Save"
    Then I should see "Updated Headshot for Ramadhan Masawe."
    # And I should see the photo


