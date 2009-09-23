Feature:
  As a social worker
  I want to manage my scheduled visits
  So that my time is optimally spent

  Background:
    Given the following users exist:
      | Role          | Name        |
      | Social Worker | Xavier Shay |

  Scenario: Rescheduling a visit
    And the following scheduled visits exist:
      | Social Worker | Child       | Date           |
      | Xavier Shay   | Juma Masawe | Wednesday this week |
    And I am signed in as "Xavier Shay"
    And I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday this week"

  Scenario: Rescheduling a visit that was missed
    And the following scheduled visits exist:
      | Social Worker | Child       | Date           |
      | Xavier Shay   | Juma Masawe | Wednesday last week |
    And I am signed in as "Xavier Shay"
    And I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday last week"

  Scenario: Scheduling a visit from my recommended list
    And the following recommended visits exist:
      | Social Worker | Child       |
      | Xavier Shay   | Juma Masawe |
    And I am signed in as "Xavier Shay"
    And I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"
    And I drag "Juma Masawe" to "Wednesday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Wednesday this week"
    Then a visit for "Juma Masawe" should not be scheduled for "Thursday this week"

  Scenario: Unscheduling a visit

  Scenario: Scheduling a visit for a child not in my recommended list
    Given the following non-recommended children exist:
      | Social Worker | Child       |
      | Xavier Shay   | Juma Masawe |
    And I am signed in as "Xavier Shay"
    And I fill in "search" with "Juma"
    And I press "Search"
    Then I should see "Juma Masawe"
    When I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"

  Scenario: Completing a visit
    And the following scheduled visits exist:
      | Social Worker | Child       | Date                |
      | Xavier Shay   | Juma Masawe | Wednesday this week |
    And I am signed in as "Xavier Shay"
    And I click "Completed"
    And I wait for page load
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday this week"
    And a home visit for "Juma Masawe" should have happened on "Wednesday this week"


