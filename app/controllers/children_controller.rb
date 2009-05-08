class ChildrenController < ApplicationController
  before_filter :build_child, :only => [:new, :create]
  before_filter :load_child,  :only => [:show]

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
  def boarding_offsite
    @children = Child.is(OffsiteBoarding).as_of(Date.today)
    render :index
  end

  def dropped_out
    @children = Child.is(Dropout).as_of(Date.today)
    render :index
  end

  def onsite
    @children = Child.is(Arrival).as_of(Date.today)
    render :index
  end

  def reunified
    @children = Child.is(Reunification).as_of(Date.today)
    render :index
  end

  def terminated
    @children = Child.is(Termination).as_of(Date.today)
    render :index
  end

  protected

  def build_child
    @child = Child.new(params[:child])
  end

  def load_child
    @child = Child.find(params[:id])
  end
end