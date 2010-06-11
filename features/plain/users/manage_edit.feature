Background:
Given an address exists with zip: "4910002", prefecture: "愛知県", ward: "Some City", area: "Some Island"
	And a user exists with last_name: "Space", first_name: "Cow", mob_email: "", mob_tel: "", male: true, username: "johan", pc_email: "spacecow@space.com", home_tel: "123456", zip3: "491", zip4: "0002", ward_area: "Some CitySome Island", question: "<saved_question>", prefecture: "愛知県", last_name_kana: "スペース", first_name_kana: "カオ", birth: "1978-6-1", building_room: "A building 45"

@pending
Scenario: An admin can edit other user's private information

@view
Scenario: View user's edit form
Given I am logged in as "johan"
When I go to the edit page of that user
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

Scenario: View user's security page
Given I am logged in as "johan"
When I go to the security page of that user
Then I should see "Security Settings" as title
	And the "Username" field should contain "johan"
	And the "Old Password" field should be empty
	And the "New Password" field should be empty
	And the "New Password Confirmation" field should be empty
	And I should see links "Info, Delete, List Users" at the bottom of the page
	And the "Answer" field should be empty
	And the "Answer Confirmation" field should be empty

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
