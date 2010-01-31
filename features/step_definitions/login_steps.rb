Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given "I go to the login page"
	And "I fill in \"Username or Email Address\" with \"#{username}\""
	And "I fill in \"Password\" with \"secret\""
	And "I press \"Log in\""
end
