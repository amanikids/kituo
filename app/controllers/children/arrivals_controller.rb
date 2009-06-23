class Children::ArrivalsController < Children::BaseController
  before_filter :build_arrival, :only => [:new, :create]
  before_filter :load_arrival,  :only => [:destroy]

  def create
    if @arrival.save
      flash[:notice] = t('children.arrivals.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @arrival.destroy
    flash[:notice] = t('children.arrivals.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_arrival
    @arrival = @child.arrivals.build(params[:arrival])
  end

  def load_arrival
    @arrival = @child.arrivals.find(params[:id])
  end
end