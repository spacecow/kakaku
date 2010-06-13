Background:
Given a user: "reiko" exists with username: "reiko"

Scenario: A user should not be able to change his username
Given I am logged in as "reiko"
When I go to the security page of user "reiko"
Then the "Username" field should contain "reiko"
	And the "Username" field should be disabled
	
Scenario: An admin should be able to change a user's username
Given I am logged in as admin
When I go to the security page of user "reiko"
	And I fill in "Username" with "arikawa"
	And I press "Update"
Then I should see "Successfully updated security settings for arikawa." as notice flash message
	And a user should exist with username: "arikawa"
	And 1 users should exist
	
Scenario: An admin can change a user's username and doesn't have to provide the user's password
Given I am logged in as admin
When I go to the security page of user "reiko"
Then the "Username" field should contain "reiko"
	And the "Username" field should be enabled
	And "old_password" should not be visible

Scenario: If the user cannot provide the correct password, he cannot change the password
Given I am logged in as "reiko"
When I go to the security page of user "reiko"
	And I press "Update"
Then I should see "Please provide your old password." as error flash message

Scenario: A user changes his password
Given I am logged in as "reiko"
When I go to the security page of user "reiko"
	And I fill in "Old Password" with "secret"
	And I fill in "New Password" with "super"
	And I fill in "New Password Confirmation" with "super"
	And I press "Update"
Then I should see "Successfully updated Security Settings." as notice flash message

Scenario: View user's security page
Given I am logged in as "reiko"
When I go to the security page of user "reiko"
Then I should see "Security Settings" as title
	And the "Username" field should contain "reiko"
	And the "Old Password" field should be empty
	And the "New Password" field should be empty
	And the "New Password Confirmation" field should be empty
	And "Where did you spend your childhood summers?" should be selected in the "Security Question" field	
	And the "Alternative Security Question" field should be empty
	And the "Security Answer" field should be empty
	And the "Answer Confirmation" field should be empty	
	And I should see links "Show Profile, Edit Profile" at the bottom of the page
	
Scenario: Admin links from a user's security page	
Given I am logged in as admin
When I go to the security page of user "reiko"
Then I should see links "Show Profile, Edit Profile, Delete User, List Users" at the bottom of the page	

@links
Scenario: Links on user's security form page
Given I am logged in as admin
When I go to the security page of user "reiko"
	And I follow "Show Profile" at the bottom of the page
Then I should be redirected to the show page of that user
When I go to the security page of user "reiko"
	And I follow "Edit Profile" at the bottom of the page
Then I should be redirected to the edit page of that user
When I go to the security page of user "reiko"
	And I follow "List Users" at the bottom of the page
Then I should be redirected to the admin users page
When I go to the security page of user "reiko"
	And I follow "Delete User" at the bottom of the page
Then I should be redirected to the admin users page
	And 0 users should exist