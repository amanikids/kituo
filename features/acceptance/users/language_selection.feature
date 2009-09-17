Feature:
  As a user
  I want to select for the app to be displayed in my native language
  So that I can best understand the application

  Background:
    Given I am on the home page

  Scenario: Default language is Swahili, since this is the preferred language for most users
    Then I should see "Karibu!"

  Scenario: English language, for Joe and the devs
    Given I click "English"
    Then I should see "Hello!"
