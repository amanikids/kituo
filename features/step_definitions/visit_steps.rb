When /^I drag "([^\"]*)" to "([^\"]*)"$/ do |child_name, date|
  date = parse_date(date).to_date.to_s(:db)
  source = page.find(:xpath, "//a[contains(text(),'#{child_name}')]/ancestor::li")
  target = page.find(:xpath, "//ul[@data-date='#{date}']")
  source.drag_to(target)
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

When /^I follow day "([^\"]*)" in the calendar$/ do |link|
  sleep 0.5
  click_link(link)
end

When /^I follow "([^\"]*)" for the visit scheduled for "([^\"]*)"$/ do |link, day|
  raise("Unimplemented for more than one scheduled visit") if ScheduledVisit.count > 1
  When %{I follow "#{link}" within ".scheduled_visits"}
end
