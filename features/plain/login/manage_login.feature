Scenario: View the log in page
When I go to the login page
Then I should see "Log in" as title
	And I should see "Don't have an account? Sign up"
	And the "Username or Email Address" field should be empty
	And the "Password" field should be empty
	And I should see "Remember me"
	And I should see "I have forgotten my password!"

@cookie
Scenario: Login with cookie
Given a user exists with username: "johan", email: "jsveholm@gmail.com", password: "secret"
When I go to the login page
	And I fill in "Username or Email Address" with "johan"
	And I fill in "Password" with "secret"
	And I check "Remember me"
	And I press "Log in"
	And I follow "Log out (johan)"
	And I follow "Log in"
Then the "Username or Email Address" field should contain "johan"
	And the "Password" field should contain "secret"
	And the "Remember me" checkbox should be checked
When I uncheck "Remember me"
	And I press "Log in"
	And I follow "Log out (johan)"
	And I follow "Log in"
Then the "Username or Email Address" field should be empty
	And the "Password" field should be empty
	And the "Remember me" checkbox should not be checked

Scenario: Links on the log in page
When I go to the login page
	And I follow "Sign up"
Then I should be redirected to the signup page
When I go to the login page
	And I follow "I have forgotten my password!"
Then I should be redirected to the new reset page

Scenario Outline: Log in
Given a user exists with username: "johan", email: "jsveholm@gmail.com", password: "secret"
When I go to the login page
	And I fill in "Username or Email Address" with "<login>"
	And I fill in "Password" with "secret"
	And I press "Log in"
Then I should be redirected to the root page
	And I should see "Successfully logged in." as notice flash message
Examples:
|	login								|
|	johan								|
|	jsveholm@gmail.com	|

Scenario: Log out
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
	And I am logged in as "johan"
When I follow "Log out"
Then I should be redirected to the root page
And I should see "Successfully logged out." as notice flash message

Scenario: If you are already logged in you should not be able to go to the login page
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
	And I am logged in as "johan"
When I go to the login page
Then I should be redirected to the root page
	And I should see "You are already logged in." as error flash message

Scenario: If a user inputs a wrong url, he should be taken to the root page (NOT IMPLEMENTED)
Given not implemented

Scenario: Cookie also for create (NOT IMPLEMENTED)
Given not implemented























