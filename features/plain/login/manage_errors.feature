Scenario Outline: Display error login messages
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
When I go to the login page
	And I fill in "Username" with "<username>"
	And I fill in "Password" with "<password>"
	And I press "Log in"
Then I should see "Invalid login or password." as error flash message
Examples:
|	username						| password	|
|											|						|
|	fe									|						|
|											|	fe				|
|	jsveholm						|						|
|	jsveholm						|	fe				|
|	jsveholm@gmail.com	|						|
|	jsveholm@gmail.com	|	fe				|