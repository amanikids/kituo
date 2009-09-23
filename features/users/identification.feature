Feature:
  As a user
  I want to identify myself to the system
  So that I can be shown information that is relevant to me

  Scenario: Social Worker identification
    Given the following users exist:
      | Type          | Name        |
      | Social Worker | Xavier Shay |
    Given I am not signed in
    Given I am on the english dashboard
    Then I should see "Hello"
    And I click "Xavier Shay"
    Then I should see "Welcome, Xavier!"
