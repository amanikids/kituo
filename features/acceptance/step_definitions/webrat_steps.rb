Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^\"]*)"$/ do |link|
  click_link(link)
end

Then /^I should see "([^\"]*)"$/ do |text|
  response.should contain(text)
end

Then /^I should not see "([^\"]*)"$/ do |text|
  response.should_not contain(text)
end
