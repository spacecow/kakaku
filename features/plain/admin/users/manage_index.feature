Scenario: View users' index
Given a user exists with username: "ernie", pc_email: "ernie@gmail.com"
	And I am logged in as admin
When I go to the admin users page
Then I should see "Users" as title
	And I should see "List of user accounts" as subtitle
	And I should see users table
	|	Username	|	Email						|	Actions 					|
	|	ernie			|	ernie@gmail.com	|	Info Edit Delete	|

@links
Scenario: Links on users' index page
Given a user exists with username: "ernie"
	And I am logged in as admin
When I go to the admin users page
	And I follow "Info" within the users table
Then I should be redirected to the show page of user with username: "ernie"
When I go to the admin users page
	And I follow "Edit" within the users table
Then I should be redirected to the admin edit page of that user
When I go to the admin users page
	And I follow "Delete" within the users table
Then I should be redirected to the admin users page
	And I should see "Successfully deleted User" as notice flash message
	And 0 users should exist

@allow-rescue
Scenario: Guest cannot list users
When I go to the admin users page
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page." as error flash message
	
@allow-rescue
Scenario: Regular users cannot list users
Given a user exists with username: "ernie"
	And I am logged in as "ernie"
When I go to the admin users page
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page." as error flash message
