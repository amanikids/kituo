Feature: Dashboard
  In order to get my work done conveniently
  As a database administrator
  I want to do things on my dashboard

  Scenario: Adding a new child into the system
    Given the following users exist:
      | Role                   | Name         |
      | Database Administrator | Fidea Chambo |
    And I am signed in as "Fidea Chambo"
    When I fill in "name" with "Juma Masawe"
    And I fill in "location" with "Arusha"
    # school?
    # when arrived at amani?
    # current state: reunified, terminated, ...
    And I press "Save"
    Then I should see "Juma Masawe" in the new children list

  #Scenario: Searching for a child
