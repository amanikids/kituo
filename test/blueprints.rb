Sham.name { Faker::Name.name }

Arrival.blueprint do
  happened_on Date.today
end

Caregiver.blueprint { name }
Child.blueprint { name }