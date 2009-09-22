Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I click "([^\"]*)"$/ do |link|
  click_link(link)
end

Then /^I should see "([^\"]*)"$/ do |text|
  assert_contain(text)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  assert_not_contain(text)
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

Then /^I wait for page load$/ do
  selenium.wait_for_page_to_load
end
