Given /^the following scheduled visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    ScheduledVisit.make(
      :scheduled_for  => Chronic.parse(hash['Date']),
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
  source = "//a[contains(text(),'#{child_name}')]/../../../descendant::span[@class='comment']"

  date = Chronic.parse(date).to_date.to_s
  destination = "//ul[@data-date='#{date}']"

  [source, destination].each do |selector|
    selenium.wait_for_element selector, :timeout_in_seconds => 5
  end
  selenium.drag_and_drop_to_object(source, destination)

  wait_for do
    run_javascript("return jQuery.activeAjaxRequestCount;") == "0"
  end
end

Then /^a visit for "([^\"]*)" should be scheduled for "([^\"]*)"$/ do |child_name, day|
  assert_not_nil Child.find_by_name(child_name).scheduled_visits.find_by_scheduled_for(Chronic.parse(day).to_date)
end

Then /^a visit for "([^\"]*)" should not be scheduled for "([^\"]*)"$/ do |child_name, day|
  assert_nil Child.find_by_name(child_name).scheduled_visits.find_by_scheduled_for(Chronic.parse(day).to_date)
end

Then /^I should see a scheduled visit for "([^\"]*)"$/ do |day|
  assert_contain_within_selector('.scheduled_visits', human_date(day))
end

Then /^I should not see a scheduled visit for "([^\"]*)"$/ do |day|
  assert_not_contain_within_selector('.scheduled_visits', human_date(day))
end

Then /^a home visit for "([^\"]*)" should have happened on "([^\"]*)"$/ do |child_name, day|
  assert_not_nil Child.find_by_name(child_name).home_visits.find_by_happened_on(Chronic.parse(day).to_date)
end

Then /^I should see a home visit for "([^\"]*)"$/ do |day|
  assert_contain_within_selector('.timeline', human_date(day))
end

When /^I follow day "([^\"]*)" in the calendar$/ do |link|
  sleep 0.5
  click_link(link)
end

When /^I follow "([^\"]*)" for the visit scheduled for "([^\"]*)"$/ do |link, day|
  # FIXME this only works if there's just one scheduled visit
  raise("Unimplemented for more than one scheduled visit") if ScheduledVisit.count > 1
  click_link_within('.scheduled_visits', link)
end
