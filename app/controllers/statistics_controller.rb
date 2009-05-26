class StatisticsController < ApplicationController
  def length_of_stay
    @bar_graph = BarGraph.new(Child.all.map(&:length_of_stay).compact.map(&divide_by(30)))
  end

  private

  def divide_by(denominator)
    lambda { |numerator| (numerator / denominator).floor }
  end
end
