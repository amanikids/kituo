class Children::OffsiteBoardingsController < Children::BaseController
  before_filter :build_offsite_boarding

  def create
    if @offsite_boarding.save
      flash[:notice] = t('children.offsite_boardings.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_offsite_boarding
    @offsite_boarding = @child.offsite_boardings.build(params[:offsite_boarding])
  end
end