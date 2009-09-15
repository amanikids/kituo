Given /^the following scheduled visits exist:$/ do |table|
  table.hashes.each do |hash|
    Child.make(
      :name => hash['Child'])
    next
    ScheduledVisit.make(
      :scheduled_for  => Chronic.parse(hash['Date']),
      :child => Child.make(
        :name => hash['Child']))
  end
end

When /^I drag "([^\"]*)" to "([^\"]*)"$/ do |child_name, day|
  source = "//a[contains(text(),'#{child_name}')]/../../div[@class='comment']"
  destination = "//ul[@id='#{day.downcase.tr(' ', '-')}']"
  selenium.drag_and_drop_to_object(source, destination)
end

Then /^the visit for "([^\"]*)" should be scheduled for "([^\"]*)"$/ do |child_name, day|
  Child.find_by_name(child_name).scheduled_visits.first.scheduled_for.should == Chroni.parse(day).to_date
end
