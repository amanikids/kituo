class ChildrenController < ApplicationController
  def show
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    @child.update_attributes(params[:child])
    redirect_to :back
  end
end
