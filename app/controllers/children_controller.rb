class ChildrenController < ApplicationController
  before_filter :find_child, :only => %w(show update resolve_duplicate)

  def on_site
    @children = Child.in_state(:on_site)
  end

  def create
    @child = Child.new(params[:child])
    @child.save!
    redirect_to :back
  end

  def show
  end

  def update
    @child.update_attributes(params[:child])
    redirect_to :back
  end

  def resolve_duplicate
    duplicate = params[:duplicate_child_id].blank? ?
      nil :
      Child.find(params[:duplicate_child_id])

    redirect_to @child.resolve_duplicate!(duplicate)
  end

  private

  def find_child
    @child = Child.find(params[:id])
  end
end
