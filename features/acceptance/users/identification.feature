Feature: 
  As a user
  I want to identify myself to the system
  So that I can be shown information that is relevant to me

  Scenario: Social Worker
    Given the following users exist:
      | Type          | Name        |
      | Social Worker | Xavier Shay |
    Given I am on the english home page
    And I follow "Xavier Shay"
    Then I should see "Welcome, Xavier!"
