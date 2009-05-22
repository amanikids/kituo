class Children::DropoutsController < Children::BaseController
  before_filter :build_dropout

  def create
    if @dropout.save
      flash[:notice] = t('children.dropouts.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  private

  def build_dropout
    @dropout = @child.dropouts.build(params[:dropout])
  end
end
