Then /^the "([^\"]*)" field should be disabled$/ do |field_label|
  field_labeled( field_label ).disabled?.should be_true
end

Then /^the "([^\"]*)" field should be enabled$/ do |field_label|
  field_labeled( field_label ).disabled?.should_not be_true
end

Then /^"([^\"]*)" should not be visible$/ do |field_id|
  assert_have_no_xpath("//input[@id='#{field_id}']")
end

When /^I fill in field "([^\"]*)" with "([^\"]*)"$/ do |field,text|
	f = field_with_id( "#{field}" )
	fill_in(field, :with => text)
end

Then /^the "([^\"]*)" field should be empty$/ do |field|
  field_labeled(field).value.should be_blank
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  begin
  	field_labeled(field).value.should =~ /#{value}/
  rescue Webrat::NotFoundError
  	field_with_id(field).value.should =~ /#{value}/
	end
end

Then /^(?:|I )should see exactly "([^\"]*)" within "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    content.should contain(/^#{text}$/)
  end
end

Then /^nothing should be selected in the "(.*)" (?:box|field)$/ do |select_id| 
  field = field_labeled(select_id) 
  selected_value = field.value[0] 
  state = :nothing_selected 
  field.options.each do |option| 
    if option.element.to_html =~ /value="#{selected_value}"/ 
      state = :something_selected 
      option.element.inner_html.should == ""
    end
  end 
  state.should == :something_selected
end

Then /^"(.*)" should be selected in the "(.*)" (?:box|field|menu)$/ do |option_text,select_id| 
  begin
  	field = field_labeled(select_id) 
	rescue Webrat::NotFoundError
		field = field_with_id(select_id) 
	end
  selected_value = field.value[0] 
  state = :nothing_selected 
  field.options.each do |option|
    if option.element.to_html =~ /selected/ 
      state = :something_selected
      option.element.inner_html.should == option_text 
    end
  end 
  state.should == :something_selected 
end

Then /^the "(.*)" field should have options "(.*)"$/ do |select_id, options| 
  field = field_labeled(select_id) 
  field.options.map{|e| e.element.inner_html.blank? ? "BLANK" : e.element.inner_html }.join(", ").should == options
end

#-------------------- ERROR

Then /^I should see no error message for (\w+) (\w+)$/ do |model, field|
  Then "the xpath \"//li[@id='#{model}_#{field}_input']/p[@class='inline-errors']\" should not exist"
end

Then /^I should see "([^\"]*)" as error message for (\w+) (\w+)$/ do |message, model, field|
  if message==""
  	Then "I should see no error message for #{model} #{field}"
  else
  	Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input p.inline-errors\""
  end
end

Then /^I should see "([^\"]*)" as hint for (\w+) (\w+)$/ do |message, model, field|
	Then "I should see /^#{message}$/ within \"li##{model}_#{field}_input p.inline-hints\""
end

Then /^I should not see "([^\"]*)" as (?:error message|hint) for (\w+) (\w+)$/ do |message, model, field|
  Then "I should not see \"#{message}\" within \"li##{model}_#{field}_input\""
end