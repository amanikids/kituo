Feature: Arrivals
  In order to get a child on the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having arrived

  Scenario: I Mark a Child as Arrived
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Arrival"
    And I select "May 7, 2009" as the date
    And I press "Save"
    Then I should see "Arrival at Amani recorded for Ramadhan Masawe."
