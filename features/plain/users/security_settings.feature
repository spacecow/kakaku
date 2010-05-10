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
Then the "Username" field should contain "reiko"
	And the "Username" field should be enabled
	
Scenario: An admin doesn't have to provide a user's password in order to change the user's security settings
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as admin
When I go to the security page of user "reiko"
Then "old_password" should not be visible

Scenario: If the user cannot provide the correct password, he cannot change the password
Given a user: "reiko" exists with username: "reiko"
	And I am logged in as "reiko"
When I go to the security page of user "reiko"
	And I press "Update"