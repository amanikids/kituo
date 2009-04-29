Feature: Arrivals
  In order to follow up well with them
  As a Social Work Coordinator
  I want to see a list of children who have recently arrived at Amani

  Scenario: A Child Arrives for the First Time
    Given child "Ramadhan Masawe" does not exist
    When I go to the new child page
    And I fill in "Name" with "Ramadhan Masawe"
    And I select "April 29, 2009" as the date
    And I press "Save"
    Then I should see "New case file started for Ramadhan Masawe."
    # TODO we like the idea of multiple flash messages per key
    # And I should see "Arrival at Amani recorded for Ramadhan Masawe."
    And I should see "April 29, 2009"
