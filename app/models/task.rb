class Task < Struct.new(:for, :by, :due_at, :description, :resolve_path)
  def self.assign_social_worker(child)
    new(child, nil, child.created_at.to_date, :unassigned_children, { :controller => 'children/social_workers', :action => 'edit', :child_id => child.id })
  end

  def self.home_visit(child, social_worker=nil)
    new(child, social_worker, 2.weeks.since(child.arrivals.first.happened_on), :upcoming_home_visits, { :controller => 'children/home_visits', :action => 'new', :child_id => child.id })
  end

  def self.record_arrival(child, social_worker=nil)
    new(child, social_worker, child.created_at.to_date, :unrecorded_arrivals, { :controller => 'children/arrivals', :action => 'new', :child_id => child.id })
  end

  def <=>(other)
    due_at <=> other.due_at
  end
end