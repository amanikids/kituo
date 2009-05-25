Sham.name { Faker::Name.name }
Sham.happened_on { Date.today }

Arrival.blueprint { happened_on }
Caregiver.blueprint { name }
Child.blueprint { name }
Dropout.blueprint { happened_on }
