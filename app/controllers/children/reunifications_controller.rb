class Children::ReunificationsController < Children::BaseController
  before_filter :build_reunification

  def create
    if @reunification.save
      flash[:notice] = t('children.reunifications.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_reunification
    @reunification = @child.reunifications.build(params[:reunification])
  end
end