class StatisticsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.svg { @bar_graph = BarGraph.new(Child.with(Arrival).map { |child| Date.today - child.arrivals.first.happened_on }, 20) }
    end
  end
end