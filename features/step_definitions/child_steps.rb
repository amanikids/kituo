When(/^I try to create a child named "(.*?)"$/) do |name|
  When 'I go to the new child page'
  And "I fill in \"Name\" with \"#{name}\""
  And 'I press "Save"'
end
