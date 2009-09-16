Given /^the following users exist:$/ do |table|
  table.hashes.each do |user_hash|
    # TODO: Support other types
    Caregiver.make(
      :name => user_hash['Name']
    )
  end
end

Given /^I am not logged in$/ do
end
