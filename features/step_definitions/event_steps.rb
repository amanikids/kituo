Given /^the following events exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.find_by_name!(hash['Child'])
    hash['Event'].constantize.make(
      :child       => child,
      :happened_on => Chronic.parse(hash['Date'])
    )
    child.recalculate_state!
  end
end

When /^I follow "([^\"]*)" for the event that happened on "([^\"]*)"$/ do |link, day|
  selector = "//*[contains(text(), '#{human_date(day)}')]/ancestor::tr/descendant::a[text()='#{link}']"
  selenium.wait_for_element selector, :timeout_in_seconds => 5
  selenium.click            selector
end

Then /^I should see an arrival event for "([^\"]*)"$/ do |day|
  assert_contain_within_selector('.timeline', "Arrived at Amani on #{human_date(day)}")
end

Then /^I should see a reunification event for "([^\"]*)"$/ do |day|
  assert_contain_within_selector('.timeline', "Reunified on #{human_date(day)}")
end

Then /^I should not see a reunification event for "([^\"]*)"$/ do |day|
  assert_not_contain_within_selector('.timeline', "Reunified on #{human_date(day)}")
end

Then /^I should see that the child's state is "([^\"]*)"$/ do |state|
  assert_contain_within_selector('.details .state .show', state)
end
