Feature: Dashboard
  In order to get my work done conveniently
  As a database administrator
  I want to do things on my dashboard

  @wip
  Scenario: Doing something?
    Given the following users exist:
      | Role                   | Name         |
      | Database Administrator | Fidea Chambo |
    When I am signed in as "Fidea Chambo"
