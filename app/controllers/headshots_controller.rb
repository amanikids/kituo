class HeadshotsController < ChildResourcesController
  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = t('headshots.update.notice', :name => @child.name)
      redirect_to @child
    else
      render :edit
    end
  end
end