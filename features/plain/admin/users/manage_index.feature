Background:
Given a user exists with username: "johan", email: "jsveholm@gmail.com"

Scenario: View users' index
Given I am logged in as admin "johan"
When I go to the admin users page
Then I should see "Users" as title
	And I should see "List of user accounts" as subtitle
	And I should see "#users" table
	|	Username	|	Email								|	Actions 		|
	|	johan			|	jsveholm@gmail.com	|	Edit Delete	|

Scenario: Links on users' index page
Given I am logged in as admin "johan"
When I go to the admin users page
	And I follow "Edit" within "table#users"
Then I should be redirected to the admin edit page of that user
When I go to the admin users page
	And I follow "Delete" within "table#users"
Then I should be redirected to the admin users page
	And 0 users should exist

@allow-rescue
Scenario: Only admin can list users
When I go to the admin users page
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."
