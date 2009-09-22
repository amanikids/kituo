module DashboardHelper
  def comment_for(visit)
    if visit.child.last_visited_on
      ['.last_visited', {:date => l(visit.child.last_visited_on, :format => :human)}]
    else
      ['.never_visited']
    end
  end

  def distance_of_time_in_weeks(day)
    this_week = Date.today.beginning_of_week
    that_week = day.to_date.beginning_of_week

    if that_week < this_week
      key = 'datetime.distance_of_time_in_words.x_weeks_ago'
    else
      key = 'datetime.distance_of_time_in_words.x_weeks_from_now'
    end

    difference_in_weeks = ((this_week - that_week) / 7).abs

    [key, {:count => difference_in_weeks}]
  end

  # Since you can't reschedule visits into the past, we don't need to include
  # empty drop targets like we do for upcoming visits
  def overdue_by_week_and_day(visits)
    overdue = visits.select {|visit|
      visit.scheduled_for < Date.today.beginning_of_week }

    unlabeled = overdue.group_by(&:scheduled_for).group_by {|day, visits|
      day.beginning_of_week
    }
  end

  # Group visits by week and day, but also include empty arrays for days
  # that we care about so that there is a drop target of rescheduling visits
  def upcoming_by_week_and_day(visits)
    visits = visits.select {|visit|
      visit.scheduled_for >= Date.today.beginning_of_week }

    data = {}.tap do |skeleton|
      weeks = (0..1).map {|x| Date.today.beginning_of_week + x.weeks }
      weeks.each do |start_of_week|
        skeleton[start_of_week] = {}

        days = (1..4).map {|x| start_of_week + x.days }
        days.each do |day|
          skeleton[start_of_week][day] = []
        end
      end

      visits.each do |visit|
        day  = visit.scheduled_for
        week = day.beginning_of_week

        skeleton[week] ||= {}
        skeleton[week][day] ||= []
        skeleton[week][day] << visit
      end
    end

    data = data.to_a.sort_by {|week, day| week }
    data.collect do |week, days|
      [week, days.to_a.sort_by {|day, visits| day }]
    end
  end
end
