Scenario Outline: Show questions
Given a user exists with username: "jsveholm", question: "<abr_question>", pc_email: "johan@space.com", mob_email: "johan@mobile.com"
When I go to the question resets page
Then the "Username" field should be empty
	And the xpath "//input[@id='answer']" should not exist
When I fill in "Username" with "<user>"
	And I press "Send"
Then I should be redirected to the question resets page
	And the "Username" field should contain "<user>"	
	And the "<question>" field should be empty
Examples:
|	user							|	abr_question			|	question																		|
|	jsveholm					|	q1								|	Where did you spend your childhood summers?	|
|	jsveholm					|	What is my name?	|	What is my name?														|
|	johan@space.com		|	q1								|	Where did you spend your childhood summers?	|
|	johan@mobile.com	|	q1								|	Where did you spend your childhood summers?	|

@view
Scenario: View of "I cannot reach my mail!" page
Given a user exists with username: "jsveholm", question: "q1"
When I go to the question resets page
Then I should see "Security Question" as title
	And I should see "Please provide your username or email address" as subtitle
	And I fill in "Username or Email Address" with "jsveholm"
	And I press "Send"
Then I should be redirected to the question resets page
Then I should see "Security Question" as title
	And I should see "Please provide an answer to your security question" as subtitle
	And the "Username or Email Address" field should contain "jsveholm"
	And the "Where did you spend your childhood summers?" field should be empty
	
Scenario: Show error messages
Given a user: "jsveholm" exists with username: "jsveholm", question: "q1", answer: "in the back of a car"
When I go to the question resets page
	And I fill in "Username or Email Address" with "jsveholm"
	And I press "Send"
	And I fill in "Where did you spend your childhood summers?" with "in the back of a car"
	And I press "Send"
Then 1 resets should exist with user: user "jsveholm"
	And I should see "Change Password for jsveholm" as title
	And I should see "Correct answer" as notice flash message
	And I should see no error flash message
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	