class Children::ReunificationsController < Children::BaseController
  before_filter :build_reunification, :only => [:new, :create]
  before_filter :load_reunification,  :only => [:destroy]

  def create
    if @reunification.save
      flash[:notice] = t('children.reunifications.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @reunification.destroy
    flash[:notice] = t('children.reunifications.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_reunification
    @reunification = @child.reunifications.build(params[:reunification])
  end

  def load_reunification
    @reunification = @child.reunifications.find(params[:id])
  end
end