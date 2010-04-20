Background:
Given a user exists with username: "ernie", pc_email: "ernie@gmail.com"

Scenario: View user's edit form
Given I am logged in as admin
When I go to the admin edit page of that user
Then I should see "Editing User" as title
	And the "Username" field should contain "ernie"
	And the "Email Address" field should contain "ernie@gmail.com"
	And the "Password" field should be empty
	And the "Password Confirmation" field should be empty
	And I should see links "Info, Delete, List Users" at the bottom of the page
	
@pending
Scenario: Edit a user
Given I am logged in as admin
When I go to the admin edit page of that user
Then 1 users should exist with username: "ernie", pc_email: "ernie@gmail.com"
	And 1 users should exist
When I fill in "Username" with "jsveholm"
	And I fill in "Email Address" with "jsveholm@gmail.com"
	And I fill in "Password" with "test"
	And I fill in "Password Confirmation" with "test"
	And I press "Update"
Then I should be redirected to the admin users page
	And I should see "Successfully updated User" as notice flash message
	And 1 users should exist with username: "jsveholm", email: "jsveholm@gmail.com"
	And 1 users should exist

Scenario: Links on user's edit form page
Given I am logged in as admin
When I go to the admin edit page of that user
	And I follow "Info" at the bottom of the page
Then I should be redirected to the show page of user with username: "ernie"
When I go to the admin edit page of that user
	And I follow "List Users" at the bottom of the page
Then I should be redirected to the admin users page
When I go to the admin edit page of that user
	And I follow "Delete" at the bottom of the page
Then I should be redirected to the admin users page
	And 0 users should exist

@allow-rescue
Scenario: Guests cannot edit users
When I go to the admin edit page of that user
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."

@allow-rescue
Scenario: Regular users cannot edit users
Given I am logged in as "ernie"
When I go to the admin edit page of that user
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."

@pending
Scenario: Invalid email address (NOT IMPLEMENTED)