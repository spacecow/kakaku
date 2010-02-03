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

Then /^I should see options "([^\"]*)" within "([^\"]*)"$/ do |options, selector|
	response.body.should have_selector( selector ) do |content|
  	content.should have_selector( 'a' ) do |links|
  		links.map{|e| e.inner_html.gsub(/<.+?>/, '')}.join(', ').should == options
		end
	end
end