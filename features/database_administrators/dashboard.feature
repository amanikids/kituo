Feature: Dashboard
  In order to get my work done conveniently
  As a database administrator
  I want to do things on my dashboard

  Background:
    Given the following users exist:
      | Role                   | Name         |
      | Database Administrator | Fidea Chambo |
    And I am signed in as "Fidea Chambo"

  Scenario: Adding a new child into the system
    When I fill in "name" with "Juma Masawe"
    And I fill in "location" with "Arusha"
    # school?
    # when arrived at amani?
    # current state: reunified, terminated, ...
    And I press "Save"
    Then I should see "Juma Masawe" in the new children list

  @wip
  Scenario: Searching for a child
    Given the following children exist:
      | Name        |
      | Juma Masawe |
    When I fill in "search" with "Juma Masawe"
    And I press "Search"
    Then I should see "Juma Masawe"
