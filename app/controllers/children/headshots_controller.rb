class Children::HeadshotsController < Children::BaseController
  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = t('children.headshot.update.notice', :name => @template.link_to(@child.name, @child))
      redirect_to @child
    else
      render :edit
    end
  end
end