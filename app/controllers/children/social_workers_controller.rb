class Children::SocialWorkersController < Children::BaseController
  def update
    if @child.update_attributes(params[:child])
      # TODO would we also link to the social worker? (may be nil)
      flash[:notice] = t('children.social_worker.update.notice', :child_name => @template.link_to(@child.name, @child), :social_worker_name => @child.social_worker_name)
      redirect_to @child
    else
      render :edit
    end
  end
end