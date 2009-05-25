class StatisticsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.svg { @bar_graph = BarGraph.new(Child.all.map(&:length_of_stay), 20) }
    end
  end
end
