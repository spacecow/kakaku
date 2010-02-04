Background:
Given a user exists with username: "johan", email: "jsveholm@gmail.com"

Scenario: View user's edit form
Given I am logged in as admin "johan"
When I go to the admin edit page of that user
Then I should see "Editing User" as title
	And the "Username" field should contain "johan"
	And the "Email Address" field should contain "jsveholm@gmail.com"
	And the "Password" field should be empty
	And the "Password Confirmation" field should be empty
	And I should see options "Info, Delete, Listing Users" within "div#links"
	
Scenario: Edit a user
Given I am logged in as admin "johan"
When I go to the admin edit page of that user
Then 1 users should exist with username: "johan", email: "jsveholm@gmail.com"
	And 1 users should exist
When I fill in "Username" with "jsveholm"
	And I fill in "Email Address" with "jsveholm@moon.space.se"
	And I fill in "Password" with "test"
	And I fill in "Password Confirmation" with "test"
	And I press "Update"
Then I should be redirected to the admin users page
	And I should see "Successfully updated User" as notice flash message
	And 1 users should exist with username: "jsveholm", email: "jsveholm@moon.space.se"
	And 1 users should exist

Scenario: Links on user's edit form page
Given I am logged in as admin "johan"
When I go to the admin edit page of that user
	And I follow "Info" within "div#links"
Then I should be redirected to the show page of that user
When I go to the admin edit page of that user
	And I follow "Listing Users" within "div#links"
Then I should be redirected to the admin users page
When I go to the admin edit page of that user
	And I follow "Delete" within "div#links"
Then I should be redirected to the admin users page
	And 0 users should exist

@allow-rescue
Scenario: Only admin can edit users
When I go to the admin edit page of that user
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."

Scenario: Invalid email address (NOT IMPLEMENTED)
Given not implemented