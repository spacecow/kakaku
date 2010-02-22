Scenario Outline: Sign up
When I go to the signup page
	And I fill in "Email Address" with "jsveholm@gmail.com"	
	And I fill in "Username" with "johan"
	And I fill in "Password" with "secret"
	And I fill in "Password Confirmation" with "secret"
	And I select "<question>" from "Security Question"
	And I fill in "Alternative Security Question" with "<alt_question>"
	And I fill in "Answer" with "I am not going to tell you that!"
	And I fill in "Answer Confirmation" with "I am not going to tell you that!"
	And I press "Sign up"
Then I should be redirected to the root page
	And I should see "Thank you for signing up! You are now logged in." as notice flash message
	And 1 users should exist with username: "johan", email: "jsveholm@gmail.com", question: "<saved_question>"
Examples:
|	question 																		|	alt_question			| saved_question		|
|	Where did you spend your childhood summers?	|										|	q1								|
|																							|	What is my name?	|	What is my name?	|
|	Type an alternative question.								|	What is my name?	|	What is my name?	|

Scenario: View the sign up page
When I go to the signup page
Then I should see "Sign up" as title
  And I should see "Already have an account? Log in"
  And the "Username" field should be empty
  And the "Email Address" field should be empty
  And the "Password" field should be empty
  And the "Password Confirmation" field should be empty
  And nothing should be selected in the "Security Question" field
	And the "Security Question" field should have options "BLANK, Where did you spend your childhood summers?, What was the last name of your favorite teacher?, What was the last name of your best childhood friend?, What was your favorite food as a child?, What was the last name of your first boss?, What is the name of the hospital where you were born?, What is the name of the street on which you grew up?, What is the name of your favorite sports team?, What was your first pet's name?, What is the last name of your best man at your wedding?, What is the last name of your maid of honor at your wedding?, What is the name of your favorite book?, What is the last name of your favorite musician?, Who is your all-time favorite movie character?, What was the make of your first car?, Who is your favorite author?, Type an alternative question."  
  And the "Alternative Security Question" field should be empty
  And the "Answer" field should be empty
  And I should see "Be aware of that this answer should be as secret as your password." as hint for user answer
When I press "Sign up"
Then I should see "Sign up" as title
  And I should see "Already have an account? Log in"
  And the "Username" field should be empty
  And the "Email Address" field should be empty
  And the "Password" field should be empty
  And the "Password Confirmation" field should be empty
  And nothing should be selected in the "Security Question" field
	And the "Security Question" field should have options "BLANK, Where did you spend your childhood summers?, What was the last name of your favorite teacher?, What was the last name of your best childhood friend?, What was your favorite food as a child?, What was the last name of your first boss?, What is the name of the hospital where you were born?, What is the name of the street on which you grew up?, What is the name of your favorite sports team?, What was your first pet's name?, What is the last name of your best man at your wedding?, What is the last name of your maid of honor at your wedding?, What is the name of your favorite book?, What is the last name of your favorite musician?, Who is your all-time favorite movie character?, What was the make of your first car?, Who is your favorite author?, Type an alternative question."  
  And the "Alternative Security Question" field should be empty
  And the "Answer" field should be empty
  And the "Answer Confirmation" field should be empty
  And I should see "Be aware of that this answer should be as secret as your password." as hint for user answer
  
Scenario: Links on the Sign up page
When I go to the signup page
	And I follow "Log in" within "div#contents"
Then I should be redirected to the login page