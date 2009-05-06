class HeadshotsController < ApplicationController
  before_filter :load_child

  def update
    if @child.update_attributes(params[:child])
      flash[:notice] = "Updated Headshot for #{@child.name}."
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