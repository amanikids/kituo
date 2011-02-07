Feature: Dashboard
  In order to get my work done conveniently
  As a database administrator
  I want to do things on my dashboard

  Background:
    Given the following users exist:
      | Role                   | Name            |
      | Social Worker          | Godfrey Pamphil |
      | Database Administrator | Fidea Chambo    |
    And the following children exist:
      | Child       |
      | Juma Masawe |
    And I am signed in as "Fidea Chambo"

  Scenario: Adding a new child into the system
    When I fill in "Name" with "Juma Masawe"
    And I fill in "Location" with "Arusha"
    # school?
    # when arrived at amani?
    # current state: reunified, terminated, ...
    And I press "Save"
    Then I should see "Juma Masawe" in the new children list

  Scenario: Creating an intentional duplicate case file
    When I fill in "Name" with "Jume Masawi"
    And I fill in "Location" with "Arusha"
    And I press "Save"
    Then I should see "Jume Masawi" in the new children list flagged as a potential duplicate
    When I follow "Jume Masawi"
    Then I should see "This may be a duplicate case file"
    When I press "No, this isn't a duplicate"
    Then I should not see "This may be a duplicate case file"

  Scenario: Creating an accidental duplicate case file
    When I fill in "Name" with "Jume Masawi"
    And I press "Save"
    When I follow "Jume Masawi"
    And I press "Merge with this case file"
    Then I should see "Juma Masawe"
    And child "Jume Masawi" should not exist

  Scenario: Searching for a child
    When I fill in "search" with "Juma Masawe"
    And I press "Search"
    Then I should see "Juma Masawe"
