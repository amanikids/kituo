Given /^the following users exist:$/ do |table|
  table.hashes.each do |user_hash|
    Caregiver.make(
      :name => user_hash['Name'],
      :role => user_hash['Role'].downcase.tr(' ', '_')
    )
  end
end

Given /^I am not signed in$/ do
  visit path_to("the english dashboard")
  unless current_url.ends_with?("/session/new")
    click_link("Not you?")
  end
end

Then /^there should be a headshot "([^\"]*)" for caregiver "([^\"]*)"$/ do |filename, name|
  Caregiver.find_by_name(name).headshot_file_name.should == filename
end