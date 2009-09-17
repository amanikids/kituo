Feature:
  As a social worker
  I want to manage my children
  So that we have accurate data in the system

  Background:
    Given the following users exist:
      | Type          | Name        |
      | Social Worker | Xavier Shay |
    And the following scheduled visits exist:
      | Child       | Location | Date           |
      | Juma Masawe | Moshi    | This Wednesday |
    And I am on the english home page
    And I click "Xavier Shay"

  @wip
  Scenario: Editing a child
    Given I click "Juma Masawe"
    And I wait for page load
    And I click "Edit"
    And I fill in "child_name" with "Jumanne"
    And I select "Xavier Shay" from "child_social_worker_id"
    And I fill in "child_location" with "Arusha"
    And I press "Save"

    Then I should see "Jumanne"
    And I should see "Xavier Shay"
    And I should see "Arusha"
    And I should not see "Juma Masawe"
    And I should not see "Moshi"
    And I should not see "No Social Worker"
