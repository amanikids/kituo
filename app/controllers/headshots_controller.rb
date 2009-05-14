class HeadshotsController < ApplicationController
  self.subnavigation_template = 'children/subnavigation'

  before_filter :load_child

  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = t('headshots.update.notice', :name => @child.name)
      redirect_to @child
    else
      render :edit
    end
  end

  protected

  def load_child
    @child = Child.find(params[:child_id])
  end
end