Feature: Tasks
  In order to make sure we remember to do things we're committed to doing
  As an Amani Caregiver
  I want to see what tasks I have scheduled

  Scenario: Saving a New Child Puts Him on the Unrecorded Arrivals Page
    When I create a child named "Ramadhan Masawe"
    And I go to the unrecorded arrivals tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: Recording an Arrival for a New Child Takes Him Off of the Unrecorded Arrivals Page
    When I create a child named "Ramadhan Masawe"
    And I record an arrival for "Ramadhan Masawe"
    And I go to the unrecorded arrivals tasks page
    Then I should not see "Ramadhan Masawe"

  Scenario: Saving a New Child Puts Him on the Unassigned Children Page
    When I create a child named "Ramadhan Masawe"
    And I go to the unassigned children tasks page
    Then I should see "Ramadhan Masawe"

  Scenario: Assigning a Child to a Social Worker Takes Him off of the Unassigned Children Page
    Given caregiver "Japhary Salum" exists
    When I create a child named "Ramadhan Masawe"
    And I assign "Ramadhan Masawe" to "Japhary Salum"
    And I go to the unassigned children tasks page
    Then I should not see "Ramadhan Masawe"
