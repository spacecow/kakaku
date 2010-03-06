@name
Scenario Outline: Name error
When I go to the signup page
	And I fill in "First Name" with "<input_first>"
	And I fill in "Last Name" with "<input_last>"
	And I press "Sign up"
Then I should see "<error_first>" as error message for user first_name
	And I should see "<error_last>" as error message for user last_name	
Examples:
|	input_first	|	input_last	|	error_first			|	error_last			|
|							|							|	can't be blank	|	can't be blank	|
|	Akira				|	Kurosawa		|									|									|

@name_kana
Scenario Outline: Name (kana) error
When I go to the signup page
	And I fill in "First Name (kana)*" with "<input_first>"
	And I fill in "Last Name (kana)*" with "<input_last>"
	And I press "Sign up"
Then I should see "<error_first>" as error message for user first_name_kana
Then I should see "<error_last>" as error message for user last_name_kana
Examples:
|	input_first	|	input_last	|	error_first								|	error_last								|
|							|							|	can't be blank						|	can't be blank						|
|	fe					|	fe					|	must be given in katakana	|	must be given in katakana	|
|	ふ						|	ふ						|	must be given in katakana	|	must be given in katakana	|
|	フ						|	フ						|														|														|
|	フふ					|	フふ					|	must be given in katakana	|	must be given in katakana	|
|	フふフ					|	フふフ					|	must be given in katakana	|	must be given in katakana	|
|	ふフ					|	ふフ					|	must be given in katakana	|	must be given in katakana	|
|	フフ					|	フフ					|														|														|

@email
Scenario Outline: Email error
Given a user exists with pc_email: "pc@mail.se", mob_email: "mob@mail.se"
When I go to the signup page
	And I fill in "Email Address (pc)*" with "<input_pc>"
	And I fill in "Email Address (mob)*" with "<input_pc>"
	And I press "Sign up"
Then I should see "<error_pc>" as error message for user pc_email
Then I should see "<error_mob>" as error message for user mob_email
Examples:
|	input_pc	|	input_mob	|	error_pc						|	error_mob						|
|						|						|	can't both be blank	|	can't both be blank	|
|	hal@space	|						|	is invalid					|											|
|						|	hal@space	|											|	is invalid					|

@gender
Scenario: Gender error
When I go to the signup page
	And I press "Sign up"
Then I should see "can't be blank" as error message for user male
When I choose "Male"
	And I press "Sign up"
Then I should see no error message for user male
When I choose "Female"
	And I press "Sign up"
Then I should see no error message for user male

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