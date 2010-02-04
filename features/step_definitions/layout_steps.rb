Then /^I should see "([^\"]*)" as notice flash message$/ do |message|
  Then "I should see \"#{message}\" within \"div#flash_notice\""
end

Then /^I should see "([^\"]*)" as error flash message$/ do |message|
  Then "I should see \"#{message}\" within \"div#flash_error\""
end

Then /^I should see "([^\"]*)" as title$/ do |message|
  Then "I should see \"#{message}\" within \"h1\""
end

Then /^I should see "([^\"]*)" as subtitle$/ do |message|
  Then "I should see \"#{message}\" within \"h3\""
end

Then /^I (should|should not) see "([^\"]*)" in the navigation bar$/ do |modal, link|
  Then "I #{modal} see \"#{link}\" within \"ul#navigation\""
end

Then /^I should see options "([^\"]*)" in the navigation bar$/ do |options|
	Then "I should see options \"#{options}\" within \"ul#navigation\""
end