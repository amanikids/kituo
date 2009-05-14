class TasksController < ApplicationController
  def index
    redirect_to :action => 'unrecorded_arrivals'
  end

  # TODO make a pseudo Task model
  def unrecorded_arrivals
    @children = Child.unrecorded_arrivals
  end

  def upcoming_home_visits
    @children = Child.upcoming_home_visits
  end
end