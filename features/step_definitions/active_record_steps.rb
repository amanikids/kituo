Given /^child "(.+)" does not exist$/ do |name|
  assert_nil Child.find_by_name(name)
end