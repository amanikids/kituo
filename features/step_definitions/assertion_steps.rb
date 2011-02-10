Then /^I should see "([^\"]*)" in the new children list$/ do |name|
  Then %{I should see "#{name}" within ".new-children"}
end

Then /^I should see "([^\"]*)" in the new children list flagged as a potential duplicate$/ do |name|
  Then %{I should see "#{name}" within ".new-children .potential-duplicate"}
end

Then /^child "([^\"]*)" should not exist$/ do |name|
  assert_nil Child.find_by_name(name)
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

Then /^there should be a headshot "([^\"]*)" for caregiver "([^\"]*)"$/ do |filename, name|
  assert_equal filename, Caregiver.find_by_name(name).headshot_file_name
end

Then /^a visit for "([^\"]*)" should be scheduled for "([^\"]*)"$/ do |child_name, day|
  assert_not_nil Child.find_by_name(child_name).scheduled_visits.find_by_scheduled_for(parse_date(day))
end

Then /^a visit for "([^\"]*)" should not be scheduled for "([^\"]*)"$/ do |child_name, day|
  assert_nil Child.find_by_name(child_name).scheduled_visits.find_by_scheduled_for(parse_date(day))
end

Then /^I should see a scheduled visit for "([^\"]*)"$/ do |day|
  Then %{I should see "#{human_date(day)}" within ".scheduled_visits"}
end

Then /^I should not see a scheduled visit for "([^\"]*)"$/ do |day|
  Then %{I should not see "#{human_date(day)}" within ".scheduled_visits"}
end

Then /^a home visit for "([^\"]*)" should have happened on "([^\"]*)"$/ do |child_name, day|
  assert_not_nil Child.find_by_name(child_name).home_visits.find_by_happened_on(parse_date(day))
end

Then /^I should see a home visit for "([^\"]*)"$/ do |day|
  Then %{I should see "#{human_date(day)}" within ".timeline"}
end
