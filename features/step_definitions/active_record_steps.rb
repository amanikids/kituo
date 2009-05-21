Given /^(\w+) "(.+)" does not exist$/ do |klass, name|
  assert_nil klass.classify.constantize.find_by_name(name)
end

Given /^(\w+) "(.+)" exists$/ do |klass, name|
  klass.classify.constantize.make(:name => name)
end

Given /^(\w+) for "(.+)" exists$/ do |klass, name|
  Child.find_by_name!(name).send(klass.tableize).make
end