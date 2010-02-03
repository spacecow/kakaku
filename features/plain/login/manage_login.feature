Scenario Outline: Log in
Given a user exists with username: "johan", email: "jsveholm@gmail.com", password: "secret"
When I go to the login page
Then I should see "Log in" as title
When I fill in "Username or Email Address" with "<login>"
	And I fill in "Password" with "secret"
	And I press "Log in"
Then I should be redirected to the root page
	And I should see "Logged in successfully." as notice flash message
Examples:
|	login								|
|	johan								|
|	jsveholm@gmail.com	|

Scenario: Sign up
When I go to the signup page
Then I should see "Sign up" as title
When I fill in "Username" with "johan"
	And I fill in "Email Address" with "jsveholm@gmail.com"
	And I fill in "Password" with "secret"
	And I fill in "Password Confirmation" with "secret"
	And I press "Sign up"
Then I should be redirected to the root page
And I should see "Thank you for signing up! You are now logged in." as notice flash message

Scenario: Log out
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
	And I am logged in as "johan"
When I follow "Log out"
Then I should be redirected to the root page
And I should see "You have been logged out." as notice flash message

Scenario: If you are logged in you should not be able to go to the login page
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
	And I am logged in as "johan"
When I go to the login page
Then I should be redirected to the root page
	And I should see "You are already logged in." as error flash message

Scenario: The username is filled in if it is given in the url
When I go to path "login?login=ishigani"
Then the "Username or Email Address" field should contain "ishigani"

Scenario: If a user inputs a wrong url, he should be taken to the root page (NOT IMPLEMENTED)
Given not implemented
























