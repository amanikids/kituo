Given /^the following scheduled visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    ScheduledVisit.make(
      :scheduled_for  => parse_date(hash['Date']),
      :child => Child.make(
        :name          => hash['Child'],
        :location      => hash['Location'] || "Moshi",
        :social_worker => social_worker))
  end
end

Given /^the following recommended visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    Child.make(
      :name          => hash['Child'],
      :social_worker => social_worker,
      :state         => 'on_site')
  end
end

Given /^the following non-recommended children exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    child = Child.make(
      :name          => hash['Child'],
      :social_worker => social_worker,
      :state         => 'on_site')
    child.home_visits.make
  end
end

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
