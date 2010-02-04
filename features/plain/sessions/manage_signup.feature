Scenario: View the sign up page
When I go to the signup page
Then I should see "Sign up" as title
  And I should see "Already have an account? Log in"
  And the "Username" field should be empty
  And the "Email Address" field should be empty
  And the "Password" field should be empty
  And the "Password Confirmation" field should be empty

Scenario: Sign up
When I go to the signup page
	And I fill in "Username" with "johan"
	And I fill in "Email Address" with "jsveholm@gmail.com"
	And I fill in "Password" with "secret"
	And I fill in "Password Confirmation" with "secret"
	And I press "Sign up"
Then I should be redirected to the root page
	And I should see "Thank you for signing up! You are now logged in." as notice flash message
	And 1 users should exist with username: "johan", email: "jsveholm@gmail.com"

Scenario: Links on the Sign up page
When I go to the signup page
	And I follow "Log in" within "div#contents"
Then I should be redirected to the login page