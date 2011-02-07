Feature: Dashboard
  In order to get my work done conveniently
  As a development officer
  I want to do things on my dashboard

  Scenario: Uploading a headshot for a kid without one
    Given the following users exist:
      | Role                | Name        |
      | Development Officer | Joe Ventura |
    And the following children with no headshot exist:
      | Child           |
      | Kalisti Jumanne |
    When I am signed in as "Joe Ventura"
    Then I should see "Kalisti Jumanne"
    When I attach the file "features/support/sample_headshot.jpg" to "child[headshot]"
    And I wait for page load
    Then I should not see "Kalisti Jumanne"
    # TODO should Joe be able to get to any kid?
