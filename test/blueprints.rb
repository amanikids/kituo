Sham.name { Faker::Name.name }
Sham.happened_on(:unique => false) { (0..30).to_a.rand.days.ago.to_date }

[Arrival, Dropout, HomeVisit, OffsiteBoarding, Reunification, Termination].each do |event|
  event.blueprint do
    child
    happened_on
  end
end

Caregiver.blueprint { name }

Child.blueprint do
  name
  location { %w(Moshi Arusha Marangu Mwanza Same).rand }
  potential_duplicate false
end

ScheduledVisit.blueprint do
  child
  scheduled_for { (1..4).to_a.rand.weeks.from_now }
end
