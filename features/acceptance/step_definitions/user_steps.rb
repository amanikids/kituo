Given /^the following users exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |user_hash|
    # TODO: Support other types
    Caregiver.make(
      :name => user_hash['Name']
    )
  end
end
