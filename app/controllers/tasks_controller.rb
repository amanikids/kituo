class TasksController < ApplicationController
  def index
    redirect_to :action => 'unrecorded_arrivals'
  end

  # TODO make a pseudo Task model
  def unrecorded_arrivals
    # TODO rename pending
    # TODO fix bug with pending (non-location events disqualify)
    @children = Child.pending
  end

  def upcoming_home_visits
    @children = Child.needing_home_visit
  end
end