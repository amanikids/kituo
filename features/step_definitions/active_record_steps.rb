Given /^(.+) "(.+)" does not exist$/ do |klass, name|
  assert_nil klass.classify.constantize.find_by_name(name)
end

Given /^(.+) "(.+)" exists$/ do |klass, name|
  klass.classify.constantize.make(:name => name)
end

