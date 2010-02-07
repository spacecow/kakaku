Scenario: Admin logged in view
Given a page exists with navlabel: "Services", position: 2
	And a page exists with navlabel: "Links", position: 1
Given I am logged in as admin
When I go to the root page
Then I should see options "Home, Links, Services, Log out (admin), Users, Pages" in the navigation bar

Scenario: User logged in view
Given a page exists with navlabel: "Services", position: 1
	And a page exists with navlabel: "Links", position: 2
Given a user exists with username: "ernie"
	And I am logged in as "ernie"
When I go to the root page
Then I should see options "Home, Services, Links, Log out (ernie), MyPage" in the navigation bar

Scenario: Logged out view
Given a page exists with navlabel: "Services", position: 1
	And a page exists with navlabel: "Links", position: 1
When I go to the root page
Then I should see options "Home, Services, Links, Log in, Contact us" in the navigation bar