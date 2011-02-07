if Rails.env.development?
  require 'faker'
  require 'machinist/active_record'
  require 'test/blueprints'

  [Caregiver, ScheduledVisit, Child].each(&:delete_all)

  godfrey = Caregiver.make(
    :role => 'social_worker'
  )

  joe     = Caregiver.make(
   :role => 'development_officer',
   :name => 'Joe Ventura'
  )

  japhary = Caregiver.make(
    :role => 'social_work_coordinator',
    :name => 'Japhary Salum'
  )

  [
    -4.days, # Overdue visit
    0.days,  # Non-standard visit
    2.days,
    2.days,
    3.days,
    1.week + 1.day
  ].each do |day|
    child = Child.make(
      :social_worker => (rand < 0.6) ? godfrey : nil
    )

    ScheduledVisit.make(
      :child         => child,
      :scheduled_for => Date.today.beginning_of_week + day
    )

    child.arrivals.make(:happened_on => 4.weeks.ago)
    child.home_visits.make(:happened_on => 3.week.ago)
    child.home_visits.make(:happened_on => 2.week.ago)
    child.reunifications.make(:happened_on => 2.weeks.ago)
    child.home_visits.make(:happened_on => 1.week.ago)
  end

  ScheduledVisit.last.child.home_visits.make

  5.times do
    godfrey.children.make(
      :state => 'on_site' # No visits, recommended
    )
  end
end
