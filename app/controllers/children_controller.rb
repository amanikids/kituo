class ChildrenController < ApplicationController
  def show
    @child = Child.find(params[:id])
  end
end
