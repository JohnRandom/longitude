Feature: "Anonymous user tries to register"
  As an anonymous user
  I would like to register
  in order to use longitude

  Scenario: "User registers successfuly"
    Given an anonymous user
     When I follow "Sign up"
      And I fill in "user_email" with "test@localhost.de"
      And I fill in "user_password" with "test"
      And I fill in "user_password_confirmation" with "test"
      And I press "user_submit"
     Then I should see "Signed up!"

  Scenario: "User mistypes password confirmation"
    Given an anonymous user
     When I follow "Sign up"
      And I fill in "user_email" with "test@localhost.de"
      And I fill in "user_password" with "test"
      And I fill in "user_password_confirmation" with "te"
      And I press "user_submit"
     Then I should see "Password doesn't match confirmation"

  Scenario: "User uses an email adress already in use"
    Given a user with email "test@localhost.de" and password "test"
     When I follow "Sign up"
      And I fill in "user_email" with "test@localhost.de"
      And I fill in "user_password" with "test"
      And I fill in "user_password_confirmation" with "te"
      And I press "user_submit"
     Then I should see "Email has already been taken"
