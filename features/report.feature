@javascript
Feature: Report Test cucumber

  Background:
    Given I test the success case
    And Default data
    And I visit the main view
    And I filled the fields of the login
      | email | user@example.com |
      | password | 12345678 |


  Scenario:
    When I click into "Log in"
    Then I should see in the view "REPORT"
