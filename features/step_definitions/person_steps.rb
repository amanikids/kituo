%w(child caregiver).each do |person|
  Given(/^#{person} "(.+)" does not exist$/) do |name|
    assert_nil person.classify.constantize.find_by_name(name)
  end

  Given(/^#{person} "(.+)" exists$/) do |name|
    person.classify.constantize.make(:name => name)
  end

  When(/^I create a #{person} named "(.*?)"$/) do |name|
    When "I go to the new #{person} page"
    And "I fill in \"Name\" with \"#{name}\""
    And 'I press "Save"'
  end

  When(/^I delete a #{person} named "(.*?)"$/) do |name|
    record = person.classify.constantize.find_by_name!(name)
    visit(polymorphic_path(record))
    click_link(dom_id(record, :delete))
  end
end

When(/^I assign "(.+)" to "(.+)"$/) do |child, social_worker|
  When "I go to the child page for \"#{child}\""
  And 'I follow "Edit Social Worker"'
  And "I choose \"#{social_worker}\""
  And 'I press "Save"'
end