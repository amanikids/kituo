%w(offsite_boarding reunification dropout termination).each do |event|
  When(/^I record an? #{event.humanize.downcase} for "(.*?)"$/) do |name|
    When "I am on the child page for \"#{name}\""
    And "I follow \"#{event.titleize}\""
    And "I select \"#{Date.today.to_s(:long)}\" as the date"
    And 'I press "Save"'
  end
end

