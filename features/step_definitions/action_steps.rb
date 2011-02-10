When /^I follow "([^\"]*)" for the event that happened on "([^\"]*)"$/ do |link, day|
  selector = "tr[data-happened_on='#{parse_date(day).to_s(:db)}']"
  When %{I follow "#{link}" within "#{selector}"}
end

When /^I drag "([^\"]*)" to "([^\"]*)"$/ do |child_name, date|
  date = parse_date(date).to_date.to_s(:db)
  source = page.find(:xpath, "//a[contains(text(),'#{child_name}')]/ancestor::li")
  target = page.find(:xpath, "//ul[@data-date='#{date}']")
  source.drag_to(target)
end

When /^I follow day "([^\"]*)" in the calendar$/ do |link|
  sleep 0.5
  click_link(link)
end

When /^I follow "([^\"]*)" for the visit scheduled for "([^\"]*)"$/ do |link, day|
  raise("Unimplemented for more than one scheduled visit") if ScheduledVisit.count > 1
  When %{I follow "#{link}" within ".scheduled_visits"}
end
