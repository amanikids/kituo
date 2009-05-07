Feature: Offsite Boardings
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as boarding somewhere else, like school

  Scenario: I Mark a Child as Boarding Offsite
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Offsite Boarding"
    And I select "May 7, 2009" as the date
    And I press "Save"
    Then I should see "Offsite Boarding recorded for Ramadhan Masawe."
