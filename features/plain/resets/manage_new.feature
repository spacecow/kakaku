Scenario Outline: User confirmation for password reset
Given a user exists with username: "spacecow", email: "jsveholm@gmail.com"
When I go to the new reset page
	And I fill in "Username or Email Address" with "<input>"
	And I press "Reset"
Then I should be redirected to the root page
	And I should see "A mail has been sent to you." as notice flash message
	And 1 resets should exist with user: that user, used: false
Examples:
|	input								|
|	spacecow						|
|	jsveholm@gmail.com	|

Scenario: View of "I have forgot my password!" page
When I go to the new reset page
Then I should see "Reset User Password" as title
	And I should see "Please provide your username or email and an email will be sent to you with instructions of how to reset your password" as subtitle
	And the "Username or Email Address" field should be empty
	And I should see "I cannot access my mail!"

Scenario: Links from "I have forgot my password!" page
When I go to the new reset page
	And I follow "I cannot access my mail!"
Then I should be redirected to the question resets page

Scenario: Email confirmation (NOT IMPLEMENTED)
Given not implemented