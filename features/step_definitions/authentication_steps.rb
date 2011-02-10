Given /^I am signed in as "([^\"]*)"$/ do |name|
  Given %{I am not signed in}
  And %{I am on the english dashboard}
  And %{I follow "#{name}"}
end

Given /^I am not signed in$/ do
  visit path_to("the english dashboard")
  unless current_url.ends_with?("/session/new")
    click_link("Not you?")
  end
end
