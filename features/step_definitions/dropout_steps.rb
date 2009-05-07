When(/^I record a dropout for "(.*?)"$/) do |name|
  When "I am on the child page for \"#{name}\""
  And 'I follow "Dropout"'
  And "I select \"#{Date.today.to_s(:long)}\" as the date"
  And 'I press "Save"'
end
