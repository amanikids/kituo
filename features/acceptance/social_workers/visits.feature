Feature:
  As a social worker
  I want to manage my scheduled visits
  So that my time is optimally spent

  Background:
    Given the following users exist:
      | Type          | Name        |
      | Social Worker | Xavier Shay |

  Scenario: Rescheduling a visit
    And the following scheduled visits exist:
      | Social Worker | Child       | Date           |
      | Xavier Shay   | Juma Masawe | This Wednesday |
    And I am on the english dashboard
    And I click "Xavier Shay"
    And I drag "Juma Masawe" to "This Thursday"
    And I wait for AJAX requests to finish
    Then the visit for "Juma Masawe" should be scheduled for "This Thursday"

  Scenario: Rescheduling a visit that was missed

  Scenario: Scheduling a visit from my recommended list

  Scenario: Unscheduling a visit

  @wip
  Scenario: Scheduling a visit for a child not in my recommended list
    Given the following children exist:
      | Name        |
      | Juma Masawe |
    And I am on the english home page
    And I follow "Xavier Shay"
    And I fill in "search" with "Juma"
    And I press "Search"
    Then I should see "Juma Masawe"
    When I drag "Juma Masawe" to "This Thursday"
    Then the visit for "Juma Masawe" should be scheduled for "This Thursday"
