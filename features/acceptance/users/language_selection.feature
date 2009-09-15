Feature: 
  As a user
  I want to select for the app to be displayed in my native language
  So that I can best understand the application

  Background:
    Given I am on the home page

  @pending
  Scenario: Swahili Default, since this is the preferred language for most users
    Then I should see "Karibu!"

  Scenario: English, for Joe and the devs
    Given I follow "English"
    Then I should see "Hello!"
