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

@zip
Scenario Outline: Zip error
When I go to the signup page
	And I fill in "user_zip3" with "<input_zip3>"
	And I fill in "user_zip4" with "<input_zip4>"
	And I press "Generate"
Then I should see "<error_zip>" as error message for user zip
	And the "user_zip3" field should contain "<output_zip3>"
	And the "user_zip4" field should contain "<output_zip4>"
Examples:
|	input_zip3	|	input_zip4	|	error_zip								|	output_zip3	|	output_zip4	|
|							|							|	can't be blank					|							|							|
|	98					|	d123				|	must be 3x4 digits			|	98					|	d123				|
|	123					|	1２					|	must be 3x4 digits			|	123					|	12					|
|	1２					|	1234				|	must be 3x4 digits			|	12					|	1234				|
|	1２３					|	1234				|	zip code does not exist	|	123					|	1234				|

@ok-zip
Scenario: If a correct zip is filled in, so will the corresponding address
Given an address exists with zip: "9800815", prefecture: "宮城県", ward: "青葉区", area: "花壇"
When I go to the signup page
	And I fill in "user_zip3" with "980"
	And I fill in "user_zip4" with "0815"
	And I press "Generate"
Then "宮城県" should be selected in the "Prefecture" field
	And the "Ward/Area" field should contain "青葉区花壇"

@address
Scenario: Address error
When I go to the signup page
	And I select "" from "Prefecture"
	And I fill in "Ward/Area" with ""
	And I press "Sign up"
Then I should see "can't be blank" as error message for user prefecture
	And I should see "can't be blank" as error message for user ward_area

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
|	１2							|									|	2						|							|
|									|	１3							|							|	3						|
|	0123d456s7890		|									|	01234567890	|							|
|									|	012g3456z7l890	|							|	01234567890	|

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

@answer_error
Scenario Outline: Answer error
When I go to the signup page
	And I fill in "Security Answer" with "<input>" 
	And I press "Sign up"
Then I should see "<output>" as error message for user answer
Examples:
|	input		|	output											|
|					|	can't be blank							|
|	secret	|	doesn't match confirmation	|

@pending
Scenario: Eliminate "Generate" button with AJAX