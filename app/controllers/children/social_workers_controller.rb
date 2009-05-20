class Children::SocialWorkersController < Children::BaseController
  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = t('children.social_worker.update.notice', :child_name => @child.name, :social_worker_name => @child.social_worker_name)
      redirect_to @child
    else
      render :edit
    end
  end
end