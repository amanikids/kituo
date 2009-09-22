class RecommendedVisit < Struct.new(:child)
  def self.for(child)
    return unless child.scheduled_visits.empty?

    if should_have_initial_home_visit?(child)
      new(child)
    elsif should_have_follow_up_home_visit?(child)
      new(child)
    elsif should_have_follow_up_home_visit_after_reunification?(child)
      new(child)
    end
  end

  def self.should_have_initial_home_visit?(child)
    child.on_site? && child.home_visits.empty?
  end

  def self.should_have_follow_up_home_visit?(child)
    child.on_site? && child.last_visited_on < 1.month.ago.to_date
  end

  def self.should_have_follow_up_home_visit_after_reunification?(child)
    child.reunified? && (child.last_visited_on.nil? || child.last_visited_on < 3.months.ago.to_date)
  end

  def id
    child.id
  end
end