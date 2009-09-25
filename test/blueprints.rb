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
  location { %w(Moshi Arusha Marangu Mwanza Same).rand }
  potential_duplicate false
end

Child.instance_eval do
  def self.make_potential_duplicate(attributes = {})
    Child.make(attributes).tap do |child|
      child.potential_duplicate = true
      child.save!
    end
  end
end

ScheduledVisit.blueprint do
  child
  scheduled_for { (1..4).to_a.rand.weeks.from_now }
end
