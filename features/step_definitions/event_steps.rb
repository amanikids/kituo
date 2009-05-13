%w(arrival home_visit offsite_boarding reunification dropout termination).each do |event|
  When(/^I record an? #{event.humanize.downcase} for "(.*?)"(?: on "(.+)")?$/) do |name, date|
    date ||= Date.today.to_s(:long)
    When "I am on the child page for \"#{name}\""
    And "I follow \"#{event.titleize}\""
    And "I select \"#{date}\" as the date"
    And 'I press "Save"'
  end
end
