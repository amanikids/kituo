class Children::HomeVisitsController < Children::BaseController
  before_filter :build_home_visit, :only => [:new, :create]
  before_filter :load_home_visit,  :only => [:destroy]

  def create
    if @home_visit.save
      flash[:notice] = t('children.home_visits.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @home_visit.destroy
    flash[:notice] = t('children.home_visits.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_home_visit
    @home_visit = @child.home_visits.build(params[:home_visit])
  end

  def load_home_visit
    @home_visit = @child.home_visits.find(params[:id])
  end
end