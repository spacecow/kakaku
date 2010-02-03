Scenario: 
Given a user exists with username: "johan", email: "jsveholm@gmail.com"
Given I am logged in as admin "johan"
Then I should see "Users" as title
And I should see "#users" table
|	Username	|	Email								|	Actions 		|
|	johan			|	jsveholm@gmail.com	|	Edit Delete	|