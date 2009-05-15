Arrival.blueprint do
  happened_on Date.today
end

Child.blueprint do
  name { Faker::Name.name }
end