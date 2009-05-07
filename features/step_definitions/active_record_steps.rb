Given /^child "(.+)" does not exist$/ do |name|
  assert_nil Child.find_by_name(name)
end

Given /^child "(.+)" exists$/ do |name|
  Child.make(:name => name)
end
