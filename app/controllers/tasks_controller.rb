class TasksController < ApplicationController
  def index
    redirect_to unassigned_children_tasks_path, :skip_contextual_magic => true
  end

  def unassigned_children
    @tasks = Task.unassigned_children
  end

  def unrecorded_arrivals
    @tasks = Task.unrecorded_arrivals
  end

  def upcoming_home_visits
    @tasks = Task.upcoming_home_visits
  end
end