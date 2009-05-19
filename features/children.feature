Feature: Children
  In order to do everything we do
  As an Amani Caregiver
  I want keep a list of children in the system

  Scenario: I Save a New Child
    Given child "Ramadhan Masawe" does not exist
    When I try to create a child named "Ramadhan Masawe"
    Then I should see "New case file started for Ramadhan Masawe."

  Scenario: Saving a New Child Puts Him on the Unrecorded Arrivals Page
    Given child "Ramadhan Masawe" does not exist
    When I try to create a child named "Ramadhan Masawe"
    And I go to the unrecorded arrivals tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: I Try to Save a Child Without a Name
    When I try to create a child named ""
    Then I should see "can't be blank"

  Scenario: I Try to Save a Child We Already Know About
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe"
    Then I should see "Potential Duplicates Found"

  Scenario: Resolving a Duplicate Name by Creating a Duplicate Child
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe"
    And I press "Create a New Case File"
    Then I should see "New case file started for Ramadhan Masawe."

  Scenario: Resolving a Duplicate Name by Selecting an Existing Child
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe"
    And I follow "Ramadhan Masawe"
    Then I should not see "New case file started for Ramadhan Masawe."
    And I should see "Ramadhan Masawe"

  Scenario: I Edit a Child's Name
    Given child "Ramadhan Masawe" exists
    When I go to the child page for "Ramadhan Masawe"
    And I follow "Edit Name"
    And I fill in "Name" with "Ramadani Masawe"
    And I press "Save"
    Then I should see "Case file updated for Ramadani Masawe."
    And I should not see "Ramadhan Masawe"

  Scenario: I Edit a Child's Name, Setting It to Blank
    Given child "Ramadhan Masawe" exists
    When I go to the child page for "Ramadhan Masawe"
    And I follow "Edit Name"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "can't be blank"
    And I should see "Ramadhan Masawe"
