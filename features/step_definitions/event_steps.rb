When /^I follow "([^\"]*)" for the event that happened on "([^\"]*)"$/ do |link, day|
  selector = "tr[data-happened_on='#{parse_date(day).to_s(:db)}']"
  When %{I follow "#{link}" within "#{selector}"}
end

Then /^I should see an arrival event for "([^\"]*)"$/ do |day|
  Then %{I should see "Arrived at Amani on #{human_date(day)}" within ".timeline"}
end

Then /^I should see a reunification event for "([^\"]*)"$/ do |day|
  Then %{I should see "Reunified on #{human_date(day)}" within ".timeline"}
end

Then /^I should not see a reunification event for "([^\"]*)"$/ do |day|
  Then %{I should not see "Reunified on #{human_date(day)}" within ".timeline"}
end

Then /^I should see that the child's state is "([^\"]*)"$/ do |state|
  Then %{I should see "#{state}" within ".details .state .show"}
end
