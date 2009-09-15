Feature:
  As a social worker
  I want to manage my scheduled visits
  So that my time is optimally spent

  Background:
    Given the following users exist:
      | Type          | Name        |
      | Social Worker | Xavier Shay |
    And the following scheduled visits exist:
      | Child       | Date           |
      | Juma Masawe | This Wednesday |
    And I am on the home page
    And I follow "Xavier Shay"

  @pending
  Scenario: Rescheduling a visit
    When I drag "Juma Masawe" to "This Thursday"
    Then the visit for "Juma Masawe" should be scheduled for "This Thursday"
