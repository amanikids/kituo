class Children::HomeVisitsController < Children::BaseController
  before_filter :build_home_visit

  def create
    if @home_visit.save
      flash[:notice] = t('children.home_visits.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_home_visit
    @home_visit = @child.home_visits.build(params[:home_visit])
  end
end