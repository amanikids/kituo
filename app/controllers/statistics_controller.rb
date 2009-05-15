class StatisticsController < ApplicationController
  def index
    @statistics = Statistic.new
  end
end