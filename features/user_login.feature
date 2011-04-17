Feature: "User tries to login"
  As an anonymous user
  I would like to log myself in
  In order to use longitude

  Scenario: "User logs in with correct credentials"
    Given a user with email "test@localhost.de" and password "test"
      And an anonymous user
     When I follow "log in"
      And I fill in "email" with "test@localhost.de"
      And I fill in "password" with "test"
      And I press "Log in"
     Then I should see "Logged in"
