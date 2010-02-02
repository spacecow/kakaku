Scenario: Log in as admin
When I go to the admin login page
Then I should see "Admin log in" as title
When I fill in "Username" with "test"
	And I fill in "Password" with "test"
	And I press "Log in"
Then I should be redirected to the admin users page
	And I should see "Successfully logged in as admin." as notice flash message

Scenario: Log out admin (NOT IMPLEMENTED)
Given not implemented

Scenario: Error messages (NOT IMPLEMENTED)
Given not implemented