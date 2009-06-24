class Children::TerminationsController < Children::BaseController
  before_filter :build_termination, :only => [:new, :create]
  before_filter :load_termination,  :only => [:destroy]

  def create
    if @termination.save
      flash[:notice] = t('children.terminations.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @termination.destroy
    flash[:notice] = t('children.terminations.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_termination
    @termination = @child.terminations.build(params[:termination])
  end

  def load_termination
    @termination = @child.terminations.find(params[:id])
  end
end