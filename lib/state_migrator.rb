class StateMigrator
  STATES = {
    Arrival         => 'on_site',
    OffsiteBoarding => 'boarding_offsite',
    Reunification   => 'reunified',
    Dropout         => 'dropped_out',
    Termination     => 'terminated'
  }

  def migrate!
    Child.find_each do |child|
      last_event = child.events.find(:first,
        :conditions => ['type != ?', 'HomeVisit'],
        :order      => 'happened_on DESC, created_at DESC')

      if last_event
        new_state = STATES.fetch(last_event.class)
      else
        new_state = 'unknown'
      end

      child.state = new_state
      child.save!
    end
  end
end
