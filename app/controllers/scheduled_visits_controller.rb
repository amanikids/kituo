class ScheduledVisitsController < ApplicationController
  before_filter :require_sign_in

  def create
    child = current_user.children.find(params[:child_id])
    visit = child.scheduled_visits.create!(filter(params[:scheduled_visit]))
    render :json => {:id => visit.id}, :status => :created
  end

  def update
    @visit = ScheduledVisit.find(params[:id])
    @visit.update_attributes(filter(params[:scheduled_visit]))
    head(:ok)
  end

  protected

  def filter(hash)
    raise BadRequest unless hash.is_a?(Hash)

    hash.slice(:scheduled_for)
  end
end
