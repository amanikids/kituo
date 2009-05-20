class TasksController < ApplicationController
  def index
    redirect_to :action => 'unrecorded_arrivals'
  end

  def unrecorded_arrivals
    @children = Child.unrecorded_arrivals
  end

  def unassigned_children
    @children = Child.without_social_worker
  end

  def upcoming_home_visits
    @children = Child.upcoming_home_visits
  end
end