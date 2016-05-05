Feature: Authorisation

  Scenario: Do correct login
    Given User is on login page
    When User types valid email and password and push submit
    Then User should see message about successful login
    And User should be on main page
    And User do logout

  Scenario Outline: Doing incorrect login
    Given User is on login page
    When User types <email>  and <password> and push submit
    Then User should see message about wrong email or password
    Examples:
      | email                     | password              |
      | nonexistinguser@mail.com  | dummy                 |
      | demo_admin@educator.io    | wrong_password        |
      |                           |                       |
      |                           | wrong_password        |
      | demo_admin@educator.io    |                       |


#  Scenario: Check remember me
#    Given User is on login page
#    And User types valid email and password
#    And User check remember me
#    And User push sign in button
#    And User destroy session
#######     cant automate
#    And User navigate to main page
#    Then User should be on main page

  Scenario: Check forgot Password
    Given User is on login page
    When User click on 'Forgot password'
    And User types email for sending reset password instructions
#    And User should see info message
    And User should get email with reset password link and navigate it
    Then User types new password
    And User should be on main page
    And User do logout
    And User do login with new password
    And User should see message about successful login
    And User should be on main page
    And User do logout

  Scenario: Do logout
    Given User is logged in
    And User should see message about successful login
    When User do logout
    Then User should not be on main page
    And if User goes back
    Then User should not be on main page
    And if User goes forward
    Then User should not be on main page
