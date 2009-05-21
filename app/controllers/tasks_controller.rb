class TasksController < ApplicationController
  def index
    redirect_to :action => 'unrecorded_arrivals'
  end

  # TODO pull the mapping inside of Task
  # TODO can we do the same inside Caregiver?
  def unrecorded_arrivals
    @tasks = Child.unrecorded_arrivals.map { |child| Task.record_arrival(child, child.social_worker) }
  end

  # TODO implement Task.assign_social_worker
  def unassigned_children
    @tasks = Child.without_social_worker.map { |child| Task.assign_social_worker(child) }
  end

  def upcoming_home_visits
    @tasks = Child.upcoming_home_visits.map { |child| Task.home_visit(child, child.social_worker) }
  end
end