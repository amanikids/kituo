When /^I follow "([^\"]*)" for the event that happened on "([^\"]*)"$/ do |link, day|
  selector = "tr[data-happened_on='#{parse_date(day).to_s(:db)}']"
  When %{I follow "#{link}" within "#{selector}"}
end

