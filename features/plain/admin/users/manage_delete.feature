Background:
	Given a user: "ernie" exists with username: "ernie", email: "ernie@gmail.com"

Scenario: View of Confirm Delete page
Given I am logged in as admin
When I go to the admin comfirm delete page of user: "ernie"
Then I should see "Confirm Delete User" as title
	And I should see "Are you sure you want to delete user 'ernie'?" as subtitle
	
Scenario: Links on Confirm Delete page
Given I am logged in as admin
When I go to the admin comfirm delete page of user: "ernie"
	And I follow "Cancel"
Then I should be redirected to the admin users page
	And 1 users should exist
When I go to the admin comfirm delete page of user: "ernie"
	And I press "Delete"
Then I should be redirected to the admin users page
	And 0 users should exist
	
@allow-rescue
Scenario: Guests cannot edit users
When I go to the admin comfirm delete page of user: "ernie"
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."

@allow-rescue
Scenario: Regular users cannot edit users
Given I am logged in as "ernie"
When I go to the admin comfirm delete page of user: "ernie"
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."