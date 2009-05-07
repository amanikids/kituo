class ArrivalsController < ApplicationController
  before_filter :load_child
  before_filter :build_arrival

  def create
    if @arrival.save
      flash[:notice] = "Arrival at Amani recorded for #{@child.name}."
      redirect_to @child
    else
      render :new
    end
  end

  private

  def load_child
    @child = Child.find(params[:child_id])
  end

  def build_arrival
    @arrival = @child.arrivals.build(params[:arrival])
  end
end