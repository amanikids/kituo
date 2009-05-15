class Statistic
  def average_stay
    average Child.with(Arrival).map { |child| (Date.today - child.arrivals.first.happened_on).days }
  end

  private

  def average(list)
    list.any? ? list.sum / list.length : 0
  end
end