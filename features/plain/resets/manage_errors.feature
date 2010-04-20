Scenario Outline: Errors for the user confirmation form
When I go to the new reset page
	And I fill in "Username or Email Address" with "<username>"
When I press "Reset"
Then I should see "<error>" as error message for reset login
Examples:
|	login									|	error						|
|												|	does not exist	|
|	rymdkossan						|	does not exist	|
|	rymdkossan@space.com	|	does not exist	|

Scenario Outline: Show error messages for wrong password
Given a user: "jsveholm" exists with username: "jsveholm", question: "q1", answer: "in the back of a car", pc_email: "jsveholm@space.com"
When I go to the question resets page
	Then I should see no error flash message
When I fill in "Username or Email Address" with "something else"
	And I press "Send"
Then I should see "Login does not exist." as error flash message
When I fill in "Username or Email Address" with "<login>"
	And I press "Send"
Then I should see no error flash message
When I fill in "Where did you spend your childhood summers?" with "on a rooftop"
	And I press "Send"
Then I should see "Incorrect answer" as error flash message
Examples:
|	login								|
|	jsveholm						|
|	jsveholm@space.com	|