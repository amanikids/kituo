class ArrivalsController < ApplicationController
  def index
    @arrivals = Arrival.all
  end

  def new
    @arrival = Arrival.new(params[:arrival])
    @arrival.build_child
  end

  def create
    @arrival = Arrival.new(params[:arrival])
    if @arrival.save
      flash[:notice] = 'Arrival recorded.'
      redirect_to :action => 'index'
    else

    end
  end
end
