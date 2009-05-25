class StatisticsController < ApplicationController
  def length_of_stay
    @bar_graph = BarGraph.new(Child.all.map(&:length_of_stay).compact.map(&days_to_months))
  end

  private

  def days_to_months
    lambda { |days| (days / 30).floor }
  end
end
