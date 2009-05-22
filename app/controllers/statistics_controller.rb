class StatisticsController < ApplicationController
  def index
    @statistic = Statistic.count(Child.all.map(&:name), :length)
  end
end