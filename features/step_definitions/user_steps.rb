Given /^I am not signed in$/ do
  visit path_to("the english dashboard")
  unless current_url.ends_with?("/session/new")
    click_link("Not you?")
  end
end

Then /^there should be a headshot "([^\"]*)" for caregiver "([^\"]*)"$/ do |filename, name|
  assert_equal filename, Caregiver.find_by_name(name).headshot_file_name
end
