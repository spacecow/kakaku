Scenario Outline: Display error login messages
Given a user exists with username: "johan", pc_email: "jsveholm@gmail.com"
When I go to the login page
	And I fill in "Username or Email Address" with "<login>"
	And I fill in "Password" with "<password>"
	And I press "Log in"
Then I should see "Invalid login or password." as error flash message
Examples:
|	login								| password	|
|											|						|
|	fe									|						|
|											|	fe				|
|	jsveholm						|						|
|	jsveholm						|	fe				|
|	jsveholm@gmail.com	|						|
|	jsveholm@gmail.com	|	fe				|