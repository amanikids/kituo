Given /^(\w+) "(.+)" does not exist$/ do |klass, name|
  assert_nil klass.classify.constantize.find_by_name(name)
end

Given /^(\w+) "(.+)" exists$/ do |klass, name|
  klass.classify.constantize.make(:name => name)
end

Given /^(\w+?) for "(.+?)"(?: on "(.+?)")? exists$/ do |klass, name, date|
  Child.find_by_name!(name).send(klass.tableize).make(:happened_on => parse_date(date))
end