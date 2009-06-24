class Children::OffsiteBoardingsController < Children::BaseController
  before_filter :build_offsite_boarding, :only => [:new, :create]
  before_filter :load_offsite_boarding,  :only => [:destroy]

  def create
    if @offsite_boarding.save
      flash[:notice] = t('children.offsite_boardings.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @offsite_boarding.destroy
    flash[:notice] = t('children.offsite_boardings.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_offsite_boarding
    @offsite_boarding = @child.offsite_boardings.build(params[:offsite_boarding])
  end

  def load_offsite_boarding
    @offsite_boarding = @child.offsite_boardings.find(params[:id])
  end
end