Feature: Dashboard
  In order to get my work done conveniently
  As a social work coordinator
  I want to do things on my dashboard

  Scenario: Assigning a child to a social worker
    Given the following users exist:
      | Role                    | Name            |
      | Social Work Coordinator | Japhary Salum   |
      | Social Worker           | Godfrey Pamphil |
    And the following children with no social worker exist:
      | Child          |
      | Ramadhan Saidi |
    When I am signed in as "Japhary Salum"
    Then I should see "Ramadhan Saidi"
    When I select "Godfrey Pamphil" from "child[social_worker_id]"
    Then I should not see "Ramadhan Saidi"
    # TODO should Joe be able to get to any kid?
