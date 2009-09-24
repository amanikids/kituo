class ChildrenController < ApplicationController
  def on_site
    @children = Child.all
  end

  def create
    @child = Child.new(params[:child])
    @child.save!
    redirect_to :back
  end

  def show
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    @child.update_attributes(params[:child])
    redirect_to :back
  end
end
