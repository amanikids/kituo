class Children::DropoutsController < Children::BaseController
  before_filter :build_dropout, :only => [:new, :create]
  before_filter :load_dropout,  :only => [:destroy]

  def create
    if @dropout.save
      flash[:notice] = t('children.dropouts.create.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :new
    end
  end

  def destroy
    @dropout.destroy
    flash[:notice] = t('children.dropouts.destroy.notice', :name => @template.link_to(@child.name, @child))
    redirect_to @child
  end

  private

  def build_dropout
    @dropout = @child.dropouts.build(params[:dropout])
  end

  def load_dropout
    @dropout = @child.dropouts.find(params[:id])
  end
end
