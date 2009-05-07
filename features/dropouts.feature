Feature: Dropouts
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having dropped out

  Scenario: I Mark a Child as Dropped Out
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Dropout"
    And I select "May 7, 2009" as the date
    And I press "Save"
    Then I should see "Dropout recorded for Ramadhan Masawe."
