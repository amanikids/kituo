Sham.name { Faker::Name.name }
Sham.happened_on(:unique => false) { (0..30).to_a.rand.days.ago.to_date }

Arrival.blueprint { happened_on }
Dropout.blueprint { happened_on }
HomeVisit.blueprint { happened_on }
OffsiteBoarding.blueprint { happened_on }
Reunification.blueprint { happened_on }
Termination.blueprint { happened_on }

Caregiver.blueprint { name }

Child.blueprint do
  name
  ignore_potential_duplicates true
  location { %w(Moshi Arusha Marangu Mwanza Same).rand }
end

ScheduledVisit.blueprint do
  child
  scheduled_for { (1..4).to_a.rand.weeks.from_now }
end
