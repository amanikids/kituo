class Task < Struct.new(:for, :by, :due_at, :description, :resolve_path)
  module ClassMethods
    def all
      (unassigned_children + unrecorded_arrivals + upcoming_home_visits).sort
    end

    def unassigned_children
      Child.without_social_worker.map { |child| assign_social_worker(child) }.sort
    end

    def unrecorded_arrivals
      Child.unrecorded_arrivals.map { |child| record_arrival(child) }.sort
    end

    def upcoming_home_visits
      Child.upcoming_home_visits.map { |child| home_visit(child) }.sort
    end

    def for_caregiver(caregiver)
      [].tap do |tasks|
        tasks << caregiver.children.unrecorded_arrivals.map { |child| record_arrival(child) }
        tasks << caregiver.children.upcoming_home_visits.map { |child| home_visit(child) }
      end.flatten.sort
    end

    def for_child(child)
      [].tap do |tasks|
        tasks << assign_social_worker(child) if Child.without_social_worker.find_by_id(child.id)
        tasks << record_arrival(child)       if Child.unrecorded_arrivals.find_by_id(child.id)
        tasks << home_visit(child)           if Child.upcoming_home_visits.find_by_id(child.id)
      end.sort
    end

    private
      # TODO these url_for hashes are hinky
      def assign_social_worker(child)
        new(child, nil, child.created_at.to_date, :unassigned_children, { :controller => 'children/social_workers', :action => 'edit', :child_id => child.id })
      end

      def home_visit(child)
        new(child, child.social_worker, 2.weeks.since(child.arrivals.first.happened_on), :upcoming_home_visits, { :controller => 'children/home_visits', :action => 'new', :child_id => child.id })
      end

      def record_arrival(child)
        new(child, child.social_worker, child.created_at.to_date, :unrecorded_arrivals, { :controller => 'children/arrivals', :action => 'new', :child_id => child.id })
      end
  end

  extend ClassMethods

  def due_distance_in_weeks
    ((due_at.to_time - Date.today.to_time).to_i / 1.week).abs
  end

  def due_in_the
    if due_distance_in_weeks.zero?
      'present'
    else
      due_at.past? ? 'past' : 'future'
    end
  end

  def <=>(other)
    due_at <=> other.due_at
  end
end
