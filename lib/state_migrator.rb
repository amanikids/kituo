class StateMigrator
  def migrate!
    Child.update_all(['state = ?', 'unknown'])
    Child.find_each do |child|
      last_event = child.events.location_changing.find(:first,
        :order => 'happened_on DESC, created_at DESC')

      child.state = last_event.try(:to_state) || 'unknown'
      child.save!
    end
  end
end
