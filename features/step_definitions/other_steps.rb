Then /^I should be redirected to (.+)$/ do |page|
  URI.parse(current_url).path.should == path_to(page)
end

Given /^not implemented$/ do
	true.should be_false
end

Then(/^I should see "(.+)" table$/) do |category, table|
  html_table = table_at("#{category}").to_a
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '') } }
  table.diff!(html_table)
end