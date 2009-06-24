%w(unassigned_children unrecorded_arrivals upcoming_home_visits).each do |task|
  Then(/^I should see an? #{task.singularize.humanize.downcase} task for "(.*?)"$/) do |name|
    response.should have_selector("##{dom_id(Child.find_by_name!(name), task)}")
  end

  Then(/^I should not see an? #{task.singularize.humanize.downcase} task for "(.*?)"$/) do |name|
    response.should_not have_selector("##{dom_id(Child.find_by_name!(name), task)}")
  end
end
