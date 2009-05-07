Feature: Reunifications
  In order to get a child off of the roll call sheet
  As an Amani Caregiver
  I want to mark a child as having been reunified

  Scenario: I Mark a Child as Reunified
    Given child "Ramadhan Masawe" exists
    And I am on the child page for "Ramadhan Masawe"
    When I follow "Reunification"
    And I select "May 7, 2009" as the date
    And I press "Save"
    Then I should see "Family Reunification recorded for Ramadhan Masawe."
