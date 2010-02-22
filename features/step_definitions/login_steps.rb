Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given "I go to the login page"
	And "I fill in \"Username or Email Address\" with \"#{username}\""
	And "I fill in \"Password\" with \"secret\""
	And "I press \"Log in\""
end

Given /^I am logged in as admin$/ do
	Given "I go to the admin login page"
	And "I fill in \"Username\" with \"admin\""
	And "I fill in \"Password\" with \"secret\""
	And "I press \"Log in\""
end

Then /^I should be logged in as "([^\"]*)"$/ do |arg1|
  Then "I should see \"Log out (johan)\""
end