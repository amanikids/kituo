Given /^I am signed in as "([^\"]*)"$/ do |name|
  Given %{I am not signed in}
  And %{I am on the english dashboard}
  And %{I follow "#{name}"}
end
