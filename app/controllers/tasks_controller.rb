class TasksController < ApplicationController
  def index
    redirect_to unassigned_children_tasks_path, :skip_contextual_magic => true
  end

  # TODO pull the mapping inside of Task
  # TODO can we do the same inside Caregiver?
  def unassigned_children
    @tasks = Child.without_social_worker.map { |child| Task.assign_social_worker(child) }.sort
  end

  def unrecorded_arrivals
    @tasks = Child.unrecorded_arrivals.map { |child| Task.record_arrival(child) }.sort
  end

  def upcoming_home_visits
    @tasks = Child.upcoming_home_visits.map { |child| Task.home_visit(child) }.sort
  end
end