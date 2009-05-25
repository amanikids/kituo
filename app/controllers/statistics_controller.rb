class StatisticsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.svg { @bar_graph = BarGraph.new(Statistic.count(Child.all.map(&:name), :length), 20) }
    end
  end
end