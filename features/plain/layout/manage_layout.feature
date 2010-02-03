@admin
Scenario: Admin logged in view
Given I am logged in as admin "johan"
When I go to the root page
Then I should see options "Home, Log out (admin), Users" in the navigation bar

Scenario: User logged in view
Given a user exists with username: "ernie"
	And I am logged in as "ernie"
When I go to the root page
Then I should see options "Home, Log out (ernie), My Page" in the navigation bar

Scenario: Logged out view
When I go to the root page
Then I should see options "Home, Log in, Contact us" in the navigation bar