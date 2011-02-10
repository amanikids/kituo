Feature:
  As a social worker
  I want to manage my scheduled visits
  So that my time is optimally spent

  Background:
    Given the following users exist:
      | Role          | Name        |
      | Social Worker | Xavier Shay |

  # matthewtodd: Augh. Features dragging into a jQuery sortable are failing
  # because driver translates target element into x, y delta to move, then
  # steps.
  # matthewtodd: (So, the wrong drop targets expand as the draggable passes
  # over them, pushing the right drop target out of the precalculated drag
  # path.)
  @javascript @problem
  Scenario: Rescheduling a visit
    And the following scheduled visits exist:
      | Social Worker | Child       | Date           |
      | Xavier Shay   | Juma Masawe | Wednesday this week |
    And I am signed in as "Xavier Shay"
    And I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday this week"

  # matthewtodd: Augh. Features dragging into a jQuery sortable are failing
  # because driver translates target element into x, y delta to move, then
  # steps.
  # matthewtodd: (So, the wrong drop targets expand as the draggable passes
  # over them, pushing the right drop target out of the precalculated drag
  # path.)
  @javascript @problem
  Scenario: Rescheduling a visit that was missed
    And the following scheduled visits exist:
      | Social Worker | Child       | Date           |
      | Xavier Shay   | Juma Masawe | Wednesday last week |
    And I am signed in as "Xavier Shay"
    And I drag "Juma Masawe" to "Thursday this week"
    Then a visit for "Juma Masawe" should be scheduled for "Thursday this week"
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday last week"

  # matthewtodd: Augh. Features dragging into a jQuery sortable are failing
  # because driver translates target element into x, y delta to move, then
  # steps.
  # matthewtodd: (So, the wrong drop targets expand as the draggable passes
  # over them, pushing the right drop target out of the precalculated drag
  # path.)
  @javascript @problem
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

  # matthewtodd: Augh. Features dragging into a jQuery sortable are failing
  # because driver translates target element into x, y delta to move, then
  # steps.
  # matthewtodd: (So, the wrong drop targets expand as the draggable passes
  # over them, pushing the right drop target out of the precalculated drag
  # path.)
  @javascript @problem
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
      | Xavier Shay   | Juma Masawe | Wednesday last week |
    And I am signed in as "Xavier Shay"
    And I follow "Completed"
    Then a visit for "Juma Masawe" should not be scheduled for "Wednesday last week"
    And a home visit for "Juma Masawe" should have happened on "Wednesday last week"


