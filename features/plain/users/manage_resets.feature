Scenario: A user cannot reset a password without a correct token
When I go to path "/change_password/fefe"
Then I should be redirected to the root page
	And I should see "Obtain a correct pass key in order to reset password." as error flash message

Scenario: A user cannot reset a password with a token that has already been used
Given a user exists with username: "johan" 
When I generate a reset token for "johan" that is already used
	And I browse to the change password page with that reset
Then I should be redirected to the root page
	And I should see "This pass key has already been used." as error flash message

Scenario: View of Reset Password page
Given a user exists with username: "johan"
When I generate a reset token for "johan"
	And I browse to the change password page with that reset
Then I should see "Change Password for johan" as title
	And the "New Password" field should be empty
	And the "New Password Confirmation" field should be empty

Scenario: Change password
Given a user exists with username: "johan"
When I generate a reset token for "johan"
	And I browse to the change password page with that reset
	And I fill in "New Password" with "majkvist"
	And I fill in "New Password Confirmation" with "majkvist"
	And I press "Change"
Then I should be redirected to the root page
	And I should see "Successfully changed password."
	And 1 resets should exist
	And 1 resets should exist with used: true
	And I should be logged in as "johan"
	
Scenario: Reset password with a correct token
Given a user exists with username: "johan"
When I generate a reset token for "johan"
	And I browse to the change password page with that reset
	And I press "Change"
Then I should see "Password cannot be left blank." as error flash message