Given /^the following children exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'])
  end
end

Given /^the following children with no headshot exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'], :headshot => nil)
  end
end

Given /^the following children with no social worker exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.make(:name => hash['Child'], :social_worker => nil)
  end
end

Given /^the following events exist:$/ do |table|
  table.hashes.each do |hash|
    child = Child.find_by_name!(hash['Child'])
    hash['Event'].constantize.make(
      :child       => child,
      :happened_on => parse_date(hash['Date'])
    )
    child.recalculate_state!
  end
end

Given /^the following users exist:$/ do |table|
  table.hashes.each do |user_hash|
    Caregiver.make(
      :name => user_hash['Name'],
      :role => user_hash['Role'].downcase.tr(' ', '_')
    )
  end
end

Given /^the following scheduled visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    ScheduledVisit.make(
      :scheduled_for  => parse_date(hash['Date']),
      :child => Child.make(
        :name          => hash['Child'],
        :location      => hash['Location'] || "Moshi",
        :social_worker => social_worker))
  end
end

Given /^the following recommended visits exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    Child.make(
      :name          => hash['Child'],
      :social_worker => social_worker,
      :state         => 'on_site')
  end
end

Given /^the following non-recommended children exist:$/ do |table|
  table.hashes.each do |hash|
    social_worker = Caregiver.find_by_name(hash['Social Worker'])
    child = Child.make(
      :name          => hash['Child'],
      :social_worker => social_worker,
      :state         => 'on_site')
    child.home_visits.make
  end
end

