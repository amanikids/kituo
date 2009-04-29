Given /^child "(.+)" does not exist$/ do |name|
  assert_nil Child.find_by_name(name)
end

Given /^child "(.+)" exists$/ do |name|
  # TODO switch to Machinist
  Child.create!(:name => name)
end