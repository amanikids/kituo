Then /^I should see "([^\"]*)" in the new children list$/ do |name|
  Then %{I should see "#{name}" within ".new-children"}
end

Then /^I should see "([^\"]*)" in the new children list flagged as a potential duplicate$/ do |name|
  Then %{I should see "#{name}" within ".new-children .potential-duplicate"}
end

Then /^child "([^\"]*)" should not exist$/ do |name|
  assert_nil Child.find_by_name(name)
end
