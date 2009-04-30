class ChildrenController < ApplicationController
  before_filter :build_child,   :only => [:new, :create]
  before_filter :prepare_child, :only => [:new]
  before_filter :load_child,    :only => [:show]

  def index
    @children = Child.all
  end

  def create
    if @child.save
      flash[:notice] = "New case file started for #{@child.name}."
      redirect_to @child
    else
      if @child.potential_duplicates.any?
        render :potential_duplicates_found
      else
        render :new
      end
    end
  end

  protected

  def build_child
    @child = Child.new(params[:child])
  end

  def prepare_child
    @child.arrivals.build if @child.arrivals.empty?
  end

  def load_child
    @child = Child.find(params[:id])
  end
end