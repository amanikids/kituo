class ChildrenController < ApplicationController
  before_filter :build_child, :only => [:new, :create]
  before_filter :load_child,  :only => [:show]

  def create
    if @child.save
      flash[:notice] = "New case file started for #{@child.name}."
      redirect_to @child
    else
      render :new
    end
  end

  protected

  def build_child
    @child = Child.new(params[:child])
    # TODO what if we're not interested in creating an arrival?
    @child.arrivals.build if @child.arrivals.empty?
  end

  def load_child
    @child = Child.find(params[:id])
  end
end