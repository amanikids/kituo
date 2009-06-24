Sham.name { Faker::Name.name }
Sham.happened_on { Date.today }

Arrival.blueprint { happened_on }
Caregiver.blueprint { name }
Child.blueprint { name }
Dropout.blueprint { happened_on }
HomeVisit.blueprint { happened_on }
OffsiteBoarding.blueprint { happened_on }
Reunification.blueprint { happened_on }
Termination.blueprint { happened_on }
