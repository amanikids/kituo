Sham.name { Faker::Name.name }
Sham.happened_on { Date.today }

Arrival.blueprint { happened_on }
Dropout.blueprint { happened_on }
HomeVisit.blueprint { happened_on }
OffsiteBoarding.blueprint { happened_on }
Reunification.blueprint { happened_on }
Termination.blueprint { happened_on }

Caregiver.blueprint { name }

Child.blueprint do
  name
  location { %w(Moshi Arusha Marangu Mwanza Same).rand }
end

ScheduledVisit.blueprint do
  child
  scheduled_for
end
