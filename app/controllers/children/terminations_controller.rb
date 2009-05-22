class Children::TerminationsController < Children::BaseController
  before_filter :build_termination

  def create
    if @termination.save
      flash[:notice] = t('children.terminations.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_termination
    @termination = @child.terminations.build(params[:termination])
  end
end