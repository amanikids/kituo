When(/^I create a caregiver named "(.*?)"$/) do |name|
  When 'I go to the new caregiver page'
  And "I fill in \"Name\" with \"#{name}\""
  And 'I press "Save"'
end

When(/^I create a child named "(.*?)"$/) do |name|
  When 'I go to the new child page'
  And "I fill in \"Name\" with \"#{name}\""
  And 'I press "Save"'
end

When(/^I assign "(.+)" to "(.+)"$/) do |child, social_worker|
  When "I go to the child page for \"#{child}\""
  And 'I follow "Edit Social Worker"'
  And "I select \"#{social_worker}\" from \"Social Worker\""
  And 'I press "Save"'
end