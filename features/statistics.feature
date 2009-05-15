Feature: Statistics
  In order to improve our credibility with visitors on tour
  As a Communications Coordinator
  I want to know how long kids usually stay at Amani

  Scenario: We Have Only Ever Had One Kid at Amani, and He's Still Here
    Given child "Ramadhan Masawe" exists
    And I record an arrival for "Ramadhan Masawe" on "13 weeks ago"
    When I go to the statistics page
    Then I should see "13 weeks"
