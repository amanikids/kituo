%w(arrival home_visit offsite_boarding reunification dropout termination).each do |event|
  When(/^I record an? #{event.humanize.downcase} for "(.*?)"(?: on "(.+)")?$/) do |name, date|
    When "I am on the child page for \"#{name}\""
    And "I follow \"#{event.titleize}\""
    And "I select \"#{parse_date(date)}\" as the date"
    And 'I press "Save"'
  end

  When(/^I delete an? #{event.humanize.downcase} for "(.*?)"$/) do |name|
    child = Child.find_by_name!(name)
    visit(child_path(child))
    within(child.send(event.tableize).last) do
      click_link('Delete')
    end
  end
end
