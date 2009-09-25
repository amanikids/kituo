Given /^the following children exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'])
  end
end

Given /^the following children with no headshot exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'], :headshot => nil)
  end
end

Given /^the following children with no social worker exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'], :social_worker => nil)
  end
end

Then /^I should see "([^\"]*)" in the new children list$/ do |name|
  assert_contain_within_selector(".new-children", name)
end

Then /^I should see "([^\"]*)" in the new children list flagged as a potential duplicate$/ do |name|
  assert_contain_within_selector('.new-children .potential-duplicate', name)
end

Then /^child "([^\"]*)" should not exist$/ do |name|
  Child.find_by_name(name).should == nil
end
