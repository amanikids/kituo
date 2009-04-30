When(/^I try to create a child named "(.*?)"(?: arriving on "(.+)")?$/) do |name, date|
  date ||= Date.today.to_s(:long)

  When 'I go to the new child page'
  And "I fill in \"Name\" with \"#{name}\""
  And "I select \"#{date}\" as the date"
  And 'I press "Save"'
end

