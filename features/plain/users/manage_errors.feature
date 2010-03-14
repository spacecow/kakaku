@name
Scenario Outline: Name error
When I go to the signup page
	And I fill in "First Name" with "<input_first>"
	And I fill in "Last Name" with "<input_last>"
	And I press "Sign up"
Then I should see "<error_first>" as error message for user first_name
	And I should see "<error_last>" as error message for user last_name	
	And the "First Name" field should contain "<input_first>"
	And the "Last Name" field should contain "<input_last>"
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
	And I should see "<error_last>" as error message for user last_name_kana
	And the "First Name (kana)*" field should contain "<input_first>"
	And the "Last Name (kana)*" field should contain "<input_last>"	
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
	And I fill in "Email Address (mob)*" with "<input_mob>"
	And I press "Sign up"
Then I should see "<error_pc>" as error message for user pc_email
	And I should see "<error_mob>" as error message for user mob_email
	And the "Email Address (pc)*" field should contain "<input_pc>"
	And the "Email Address (mob)*" field should contain "<input_mob>"	
Examples:
|	input_pc		|	input_mob		|	error_pc								|	error_mob								|
|							|							|	can't both be blank			|	can't both be blank			|
|							|	hal@space		|													|	is invalid							|
|	hal@space		|							|	is invalid							|													|
|	hal@space		|	hal@space		|	is invalid							|	is invalid							|
|	pc@mail.se	|							|	has already been taken	|													|
|							|	mob@mail.se	|													|	has already been taken	|
|	pc@mail.se	|	mob@mail.se	|	has already been taken	|	has already been taken	|
|							|	pc@mail.se	|													|													|
|	mob@mail.se	|							|													|													|
|	mob@mail.se	|	pc@mail.se	|													|													|

@tel
Scenario Outline: Telephone error
Given a user exists with home_tel: "12345", mob_tel: "67890"
When I go to the signup page
	And I fill in "Telephone (home)*" with "<input_home>"
	And I fill in "Telephone (mob)*" with "<input_mob>"
	And I press "Sign up"
Then I should see "<error_home>" as error message for user home_tel
	And I should see "<error_mob>" as error message for user mob_tel
	And the "Telephone (home)*" field should contain "<input_home>"
	And the "Telephone (mob)*" field should contain "<input_mob>"	
Examples:
|	input_home		|	input_mob				|	error_home							|	error_mob								|
|								|									|	can't both be blank			|	can't both be blank			|
|	\*47382				|									|	is invalid							|													|
|								|	0573e						|													|	is invalid							|
|	12345					|									|	has already been taken	|													|
|								|	67890						|													|	has already been taken	|
|	12345					|	67890						|	has already been taken	|	has already been taken	|

@tel_format
Scenario Outline: Telephone number are not saved with japanese numbers
When I go to the signup page
	And I fill in "Telephone (home)*" with "<input_home>"
	And I fill in "Telephone (mob)*" with "<input_mob>"
	And I press "Sign up"
Then the "Telephone (home)*" field should contain "<output_home>"
	And the "Telephone (mob)*" field should contain "<output_mob>"
Examples:
|	input_home			|	input_mob				|	output_home	|	output_mob	|
|	01234567890			|									|	01234567890	|							|
|									|	01234567890			|							|	01234567890	|
|	0123-456-7890		|									|	01234567890	|							|
|									|	012-3456-7-890	|							|	01234567890	|
|	０１２３-４５６７８９ー０		|									|	01234567890	|							|
|									|	012-3456-7-890	|							|	01234567890	|
|	１								|									|	1						|							|
|									|	１								|							|	1						|

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

Scenario: Phone number can be written with japanese numbers (NOT IMPLEMENTED)
Given not implemented

Scenario: Phone numbers are saved without lines (NOT IMPLEMENTED)
Given not implemented