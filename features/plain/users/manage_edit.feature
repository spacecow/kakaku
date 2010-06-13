Background:
Given an address exists with zip: "4910002", prefecture: "愛知県", ward: "Some City", area: "Some Island"
	And a user: "johan" exists with last_name: "Space", first_name: "Cow", mob_email: "", mob_tel: "", male: true, username: "johan", pc_email: "spacecow@space.com", home_tel: "123456", zip3: "491", zip4: "0002", ward_area: "Some CitySome Island", question: "q1", prefecture: "愛知県", last_name_kana: "スペース", first_name_kana: "カオ", birth: "1978-6-1", building_room: "A building 45"

@view
Scenario: View user's edit form
Given I am logged in as "johan"
When I go to the edit page of user "johan"
Then I should see "Editing User" as title
	And the "Last Name" field should contain "Space"
	And the "First Name" field should contain "Cow"
	And the "Last Name (kana)*" field should contain "スペース"
	And the "First Name (kana)*" field should contain "カオ"
	And the "Male" checkbox should be checked
	And "1978" should be selected in the "user_birth_1i" field
	And "June" should be selected in the "user_birth_2i" field
	And "1" should be selected in the "user_birth_3i" field
	And the "Email Address (pc)*" field should contain "spacecow@space.com"
	And the "Email Address (mob)*" field should be empty
	And the "Telephone (home)*" field should contain "123456"
	And the "Telephone (mob)*" field should be empty
	And the "user_zip3" field should contain "491"
	And the "user_zip4" field should contain "0002"
	And "愛知県" should be selected in the "Prefecture" field
	And the "Ward/Area" field should contain "Some CitySome Island"
	And the "Building/Room" field should contain "A building"
	And I should see links "Show Profile, Security Settings" at the bottom of the page

@admin
Scenario: Admin links from a user's edit page
Given I am logged in as admin
When I go to the edit page of user "johan"
	Then I should see links "Show Profile, Security Settings, Delete User, List Users" at the bottom of the page

@edit
Scenario Outline: Edit a user
Given I am logged in as <user>
When I go to the edit page of user "johan"
When I fill in "Email Address (mob)*" with "spacecow@softbank.ne.jp"
	And I press "Update"
Then I should be redirected to the show page of user "johan"
	And I should see "Successfully updated user" as notice flash message
	And a user should exist with last_name: "Space", first_name: "Cow", mob_email: "spacecow@softbank.ne.jp", mob_tel: "", male: true, username: "johan", pc_email: "spacecow@space.com", home_tel: "123456", zip3: "491", zip4: "0002", ward_area: "Some CitySome Island", question: "q1", prefecture: "愛知県", last_name_kana: "スペース", first_name_kana: "カオ", birth: "1978-6-1", building_room: "A building 45"
	And 1 users should exist
Examples:
|	user 		|
|	admin		|
|	"johan"	|

@links
Scenario: Links on user's edit form page
Given I am logged in as admin
When I go to the edit page of user "johan"
	And I follow "Show Profile" at the bottom of the page
Then I should be redirected to the show page of user "johan"
When I go to the edit page of user "johan"
	And I follow "Security Settings" at the bottom of the page
Then I should be redirected to the security page of user "johan"
When I go to the edit page of user "johan"
	And I follow "List Users" at the bottom of the page
Then I should be redirected to the admin users page
When I go to the edit page of user "johan"
	And I follow "Delete User" at the bottom of the page
Then I should be redirected to the admin users page
	And 0 users should exist

@allow-rescue
Scenario: Guests cannot edit users
When I go to the admin edit page of that user
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."

@allow-rescue
Scenario: Regular users cannot edit orher users
Ginve a user: "ernie" exists with username: "ernie"
	And I am logged in as "ernie"
When I go to the edit page of user "johan"
Then I should be redirected to the root page
	And I should see "You are not authorized to access this page."
