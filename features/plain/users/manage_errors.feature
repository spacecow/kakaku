Scenario Outline: Question error
When I go to the signup page
	And I select "<question>" from "Security Question"
	And I fill in "Alternative Security Question" with "<alt_question>" 
	And I press "Sign up"
Then I should see "<error_question>" as error message for user question
	And I should see "<error_alt_question>" as error message for user alt_question
Examples:
|	question											|	alt_question			|	error_question					|	error_alt_question			|
|																|										|	can't be blank					|	can't be blank					|
|	Type an alternative question.	|										|													|	can't be blank					|
|	Who is your favorite author?	|	What is my name?	|	can't both be filled in	|	can't both be filled in	|

Scenario Outline: OK Questions
When I go to the signup page
	And I select "<question>" from "Security Question"
	And I fill in "Alternative Security Question" with "<alt_question>" 
	And I press "Sign up"
Then I should not see "can't be blank" as error message for user question
	And I should not see "can't be blank" as error message for user alt_question
	And I should not see "can't both be filled in" as error message for user question
	And I should not see "can't both be filled in" as error message for user alt_question	
Examples:
|	question											|	alt_question			|
|	Who is your favorite author?	|										|
|																|	What is my name?	|
|	Type an alternative question.	|	What is my name?	|

Scenario Outline: Answer error
When I go to the signup page
	And I fill in "Answer" with "<input>" 
	And I press "Sign up"
Then I should see "<output>" as error message for user answer
Examples:
|	input		|	output											|
|					|	can't be blank							|
|	secret	|	doesn't match confirmation	|