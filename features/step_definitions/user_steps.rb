Given /^I am not signed in$/ do
  visit path_to("the english dashboard")
  unless current_url.ends_with?("/session/new")
    click_link("Not you?")
  end
end
