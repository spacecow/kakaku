Then /^I should be redirected to (.+)$/ do |page|
  URI.parse(current_url).path.should == path_to(page)
end

Given /^not implemented$/ do
	true.should be_false
end