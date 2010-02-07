#-------------------- FLASH

Then /^I should see "([^\"]*)" as notice flash message$/ do |message|
  Then "I should see \"#{message}\" within \"div#flash_notice\""
end

Then /^I should see "([^\"]*)" as error flash message$/ do |message|
  Then "I should see \"#{message}\" within \"div#flash_error\""
end


#-------------------- NAVIGATION BAR

Then /^I (should|should not) see "([^\"]*)" in the navigation bar$/ do |modal, link|
  Then "I #{modal} see \"#{link}\" within \"ul#navigation\""
end

Then /^I should see options "([^\"]*)" in the navigation bar$/ do |options|
	Then "I should see options \"#{options}\" within \"ul#navigation\""
end


#-------------------- PAGE

Then /^I should see "([^\"]*)" as title$/ do |message|
  Then "I should see \"#{message}\" within \"h1\""
end

Then /^I should see "([^\"]*)" as subtitle$/ do |message|
  Then "I should see \"#{message}\" within \"h3\""
end

When /^I follow "([^\"]*)" within the users table$/ do |link|
	When "I follow \"#{link}\" within \"table#users\""
end

When /^I follow "([^\"]*)" at the bottom of the page$/ do |link|
	When "I follow \"#{link}\" within \"div#bottom_links\""
end

Then /^I should see links "([^\"]*)" at the (?:top and bottom|bottom and top) of the page$/ do |options|
	Then "I should see links \"#{options}\" at the top of the page"
	Then "I should see links \"#{options}\" at the bottom of the page"
end

Then /^I should see links "([^\"]*)" at the (bottom|top) of the page$/ do |options, position|
	Then "I should see options \"#{options}\" within \"div##{position}_links\""
end

Then /^I should see no links at the (?:top nor bottom|bottom nor top) of the page$/ do
	Then "I should see no links at the top of the page"
	Then "I should see no links at the bottom of the page"
end

Then /^I should see no links at the (bottom|top) of the page$/ do |position|
	Then "I should see no options within \"div##{position}_links\""
end


#-------------------- ERROR

Then /^I should see "([^\"]*)" as (?:error message|hint) for (\w+) (\w+)$/ do |message, model, field|
  Then "I should see \"#{message}\" within \"li##{model}_#{field}_input\""
end

























