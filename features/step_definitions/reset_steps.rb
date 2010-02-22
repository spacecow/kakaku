Given /^I generate a reset token for "([^\"]*)"( that is already used)?$/ do |username, used|
	Given "I go to the new reset page"
	And "I fill in \"Username\" with \"#{username}\""
	And "I press \"Reset\""
	Reset.last.update_attribute( :used, true ) unless used.blank?
end

When /^I browse to the change password page with #{capture_model}$/ do |name|
	When "I go to path \"/change_password/#{find_model(name)[0].token}\""
end