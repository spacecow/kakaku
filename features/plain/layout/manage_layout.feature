Scenario Outline: Logged in view
Given a user exists with username: "johan", roles_mask: 1
	And a user exists with username: "ernie"
	And I am logged in as "<user>"
When I go to the root page
Then I should see "Home" in the navigation bar
	And I should see "Log out (<user>)" in the navigation bar
	And I <modal> see "Users" in the navigation bar
Examples:
|	user	| modal				|
|	johan	|	should 		 	|
|	ernie	|	should not 	|

Scenario: Logged out view
When I go to the root page
Then I should see "Home" in the navigation bar
	And I should see "Log in" in the navigation bar
	And I should see "Contact us" in the navigation bar