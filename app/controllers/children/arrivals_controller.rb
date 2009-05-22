class Children::ArrivalsController < Children::BaseController
  before_filter :build_arrival

  def create
    if @arrival.save
      flash[:notice] = t('children.arrivals.create.notice', :name => @template.link_to(@child.name, @child))
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