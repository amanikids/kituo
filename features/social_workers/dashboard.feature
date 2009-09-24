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
