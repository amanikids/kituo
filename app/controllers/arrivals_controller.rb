class ArrivalsController < EventsController
  before_filter :build_arrival

  def create
    if @arrival.save
      flash[:notice] = t('arrivals.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_arrival
    @arrival = @child.arrivals.build(params[:arrival])
  end
end