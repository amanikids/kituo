class Task < Struct.new(:for, :by, :due_at, :description, :resolve_path)
  def self.record_arrival(child, social_worker)
    new(child, social_worker, child.created_at.to_date, :unrecorded_arrivals, [child, child.arrivals.build])
  end

  def self.home_visit(child, social_worker)
    new(child, social_worker, 2.weeks.since(child.arrivals.first.happened_on), :upcoming_home_visits, [child, child.home_visits.build])
  end

  def <=>(other)
    due_at <=> other.due_at
  end
end