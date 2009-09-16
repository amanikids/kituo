Given /^the following scheduled visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    ScheduledVisit.make(
      :scheduled_for  => Chronic.parse(hash['Date']),
      :child => Child.make(
        :name          => hash['Child'],
        :social_worker => social_worker))
  end
end

When /^I drag "([^\"]*)" to "([^\"]*)"$/ do |child_name, date|
  source = "//a[contains(text(),'#{child_name}')]/../../../descendant::span[@class='comment']"

  date = Chronic.parse(date).to_date.to_s
  destination = "//ul[@data-date='#{date}']"

  [source, destination].each do |selector|
    selenium.wait_for_element selector, :timeout_in_seconds => 5
  end
  selenium.drag_and_drop_to_object(source, destination)
end

When /^I wait for AJAX requests to finish$/ do
  wait_for do
    run_javascript("return jQuery.activeAjaxRequestCount;") == "0"
  end
end

Then /^the visit for "([^\"]*)" should be scheduled for "([^\"]*)"$/ do |child_name, day|
  Child.find_by_name(child_name).scheduled_visits.first.scheduled_for.should == Chronic.parse(day).to_date
end
