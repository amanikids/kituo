Feature: Dashboard
  In order to get my work done conveniently
  As a social worker
  I want to do things on my dashboard

  Scenario: Printing out today's roll call sheet
    Given the following users exist:
      | Role          | Name            |
      | Social Worker | Godfrey Pamphil |
    When I am signed in as "Godfrey Pamphil"
    Then I should see "Print this week's roll call sheet"
    # Sadly, we can't make assertions about the PDF with Selenium as Firefox
    # just downloads it and opens it with Preview.

  Scenario: Creating a new case file (adding a new child)
    Given the following users exist:
      | Role          | Name            |
      | Social Worker | Godfrey Pamphil |
    When I am signed in as "Godfrey Pamphil"
    Then I should see "Open a new case file"

    When I fill in "name" with "Juma Masawe"
    And I fill in "location" with "Arusha"
    And I press "Save"
    Then I should see "Juma Masawe" in the new children list

    When I click "Juma Masawe"
    Then I should see an arrival event for "today"

  Scenario: Creating an intentional duplicate case file
    Given the following users exist:
      | Role          | Name            |
      | Social Worker | Godfrey Pamphil |
    And the following children exist:
      | Child       |
      | Juma Masawe |
    When I am signed in as "Godfrey Pamphil"
    And I fill in "name" with "Jume Masawi"
    And I fill in "location" with "Arusha"
    And I press "Save"
    Then I should see "Jume Masawi" in the new children list flagged as a potential duplicate
    When I click "Jume Masawi"
    Then I should see "This may be a duplicate case file"
    When I press "No, this isn't a duplicate"
    Then I should not see "This may be a duplicate case file"

  Scenario: Creating an accidental duplicate case file
    Given the following users exist:
      | Role          | Name            |
      | Social Worker | Godfrey Pamphil |
    And the following children exist:
      | Child       |
      | Juma Masawe |
    When I am signed in as "Godfrey Pamphil"
    And I fill in "name" with "Jume Masawi"
    And I fill in "location" with "Arusha"
    And I press "Save"
    Then I should see "Jume Masawi" in the new children list flagged as a potential duplicate
    When I click "Jume Masawi"
    Then I should see "This may be a duplicate case file"
    When I press "Merge with this case file"
    And I wait for page load
    Then I should see "Juma Masawe"
    And child "Jume Masawi" should not exist
