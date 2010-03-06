Then /^the "([^\"]*)" field should be empty$/ do |field|
  field_labeled(field).value.should be_blank
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