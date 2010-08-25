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
    When I fill in "name" with "Juma Masawe"
    And I fill in "location" with "Arusha"
    # school?
    # when arrived at amani?
    # current state: reunified, terminated, ...
    And I press "Save"
    Then I should see "Juma Masawe" in the new children list

  Scenario: Creating an intentional duplicate case file
    When I fill in "name" with "Jume Masawi"
    And I fill in "location" with "Arusha"
    And I press "Save"
    Then I should see "Jume Masawi" in the new children list flagged as a potential duplicate
    When I click "Jume Masawi"
    Then I should see "This may be a duplicate case file"
    When I press "No, this isn't a duplicate"
    And I wait for page load
    Then I should not see "This may be a duplicate case file"

  Scenario: Creating an accidental duplicate case file
    And the following scheduled visits exist:
      | Social Worker   | Child       | Date  |
      | Godfrey Pamphil | Jume Masawi | Today |
    When I click "Jume Masawi"
    And I press "Merge with this case file"
    And I wait for page load
    Then I should see "Juma Masawe"
    And I should see a scheduled visit for "today"
    And child "Jume Masawi" should not exist

  Scenario: Searching for a child
    When I fill in "search" with "Juma Masawe"
    And I press "Search"
    Then I should see "Juma Masawe"
