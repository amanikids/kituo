Feature: Arrivals
  In order to follow up well with them
  As a Social Work Coordinator
  I want to see a list of children who have recently arrived at Amani

  Scenario: A Child Arrives for the First Time
    Given child "Ramadhan Masawe" does not exist
    When I go to the new arrivals page
    And I fill in "Name" with "Ramadhan Masawe"
    And I select "April 29, 2009" as the date
    And I press "Save"
    And I go to the arrivals page
    Then I should see "Ramadhan Masawe"
