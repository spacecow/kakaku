Scenario: Log in as admin
When I go to the admin login page
Then I should see "Admin log in" as title
When I fill in "Username" with "johan"
	And I fill in "Password" with "secret"
	And I press "Log in"
Then I should be redirected to the admin users page
	And I should see "Successfully logged in as admin." as notice flash message

Scenario: Log out admin
Given I am logged in as admin "johan"
When I follow "Log out"
Then I should be redirected to the admin login page
	And I should see "Successfully logged out admin." as notice flash message

Scenario: View
Given a user exists with username: "johan"
	And I am logged in as "johan"
	And I am logged in as admin "johan"
	And I follow "Log out (admin)"
	And I follow "Log out (johan)"
	
Scenario: If you are logged in as admin you should not be able to go to the login page
Given I am logged in as admin "johan"
When I go to the admin login page
Then I should be redirected to the admin users page
	And I should see "You are already logged in as admin." as error flash message	
	
Scenario: The username is filled in if it is given in the url (NOT IMPLEMENTED)
When I go to path "admin/login?username=ishigani"
Then the "Username" field should contain "ishigani"