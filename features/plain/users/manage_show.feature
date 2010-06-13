@allow-rescue
Scenario: Users should not be able to see other users' mypage
Given a user: "johan" exists with username: "johan"
	And a user: "reiko" exists with username: "reiko"
	And I am logged in as "johan"
When I go to the show page of user "johan"
Then I should be redirected to the show page of user "johan"
When I go to the show page of user "reiko"
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page." as error flash message

@allow-rescue
Scenario: Guests should not be able to see users' mypage
Given a user exists
When I go to the show page of that user
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page." as error flash message

Scenario: Admins can view everyone's mypage
Given a user: "johan" exists with username: "johan"
	And a user: "reiko" exists with username: "reiko"
	And I am logged in as admin
When I go to the show page of user "johan"
Then I should be redirected to the show page of user "johan"
When I go to the show page of user "reiko"
Then I should be redirected to the show page of user "reiko"

Scenario: Links from a user's show page as admin
Given a user exists
	And I am logged in as admin
When I go to the show page of that user
Then I should see links "Edit Profile, Security Settings, Delete User, List Users" at the bottom of the page

@links
Scenario: A regular user links from his own show page
Given a user exists with username: "ernie"
	And I am logged in as "ernie"
When I go to the show page of that user
Then I should see links "Edit Profile, Security Settings" at the bottom of the page