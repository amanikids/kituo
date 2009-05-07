Feature: Arrivals
  In order to follow up well with them
  As a Social Work Coordinator
  I want to see a list of children who have recently arrived at Amani

  Scenario: A Child Arrives for the First Time
    Given child "Ramadhan Masawe" does not exist
    When I try to create a child named "Ramadhan Masawe" arriving on "April 29, 2009"
    Then I should see "New case file started for Ramadhan Masawe."
    # TODO we like the idea of multiple flash messages per key
    # And I should see "Arrival at Amani recorded for Ramadhan Masawe."
    And I should see "April 29, 2009"

  Scenario: I Try to Save a Child Without a Name
    When I try to create a child named ""
    Then I should see "can't be blank"

  Scenario: A Child Returns to Amani
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe"
    Then I should see "Potential Duplicates Found"

  Scenario: Resolving a Duplicate Name by Creating a Duplicate Child
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe" arriving on "April 29, 2009"
    And I press "Create a New Case File"
    Then I should see "New case file started for Ramadhan Masawe."
    And I should see "April 29, 2009"

  Scenario: Resolving a Duplicate Name by Selecting an Existing Child
    Given child "Ramadhan Masawe" exists
    When I try to create a child named "Ramadhan Masawe" arriving on "April 29, 2009"
    And I press "Record Arrival on April 29, 2009"
    Then I should not see "New case file started for Ramadhan Masawe."
    And I should see "Arrival at Amani recorded for Ramadhan Masawe."
    And I should see "April 29, 2009"
