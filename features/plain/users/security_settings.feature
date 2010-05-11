Scenario: A user should not be able to change his username
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as "reiko"
When I go to the security page of user "reiko"
Then the "Username" field should contain "reiko"
	And the "Username" field should be disabled
	
Scenario: An admin should be able to change a user's username
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as admin
When I go to the security page of user "reiko"
	And I fill in "Username" with "arikawa"
	And I press "Update"
Then I should see "Successfully updated Security Settings for arikawa." as notice flash message
	And a user should exist with username: "arikawa"
	And 1 users should exist
	
Scenario: An admin can change a user's username and doesn't have to provide the user's password
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as admin
When I go to the security page of user "reiko"
Then the "Username" field should contain "reiko"
	And the "Username" field should be enabled
	And "old_password" should not be visible

Scenario: If the user cannot provide the correct password, he cannot change the password
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as "reiko"
When I go to the security page of user "reiko"
	And I press "Update"
Then I should see "Please provide your old password." as error flash message

Scenario: A user changes his password
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as "reiko"
When I go to the security page of user "reiko"
	And I fill in "Old Password" with "secret"
	And I fill in "New Password" with "super"
	And I fill in "New Password Confirmation" with "super"
	And I press "Update"
Then I should see "Successfully updated Security Settings." as notice flash message