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
        flash.now[:error] = "Whoops! Check your work."
        render :new
      end
    end
  end

  # ===========================================================================
  # Custom Collection Actions
  # ===========================================================================
  %w(offsite_boardings reunifications dropouts terminations).each do |status|
    define_method(status) do
      @children = Child.is(status.classify.constantize).as_of(Date.today)
      render :index
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