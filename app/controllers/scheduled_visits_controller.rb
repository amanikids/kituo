class ScheduledVisitsController < ApplicationController
  class BadRequest < RuntimeError; end;

  def update
    @visit = ScheduledVisit.find(params[:id])
    @visit.update_attributes(filter(params[:scheduled_visit]))
    head(:ok)
  rescue BadRequest
    head(:bad_request)
  end

  protected

  def filter(hash)
    raise BadRequest unless hash.is_a?(Hash)

    hash.slice(:scheduled_for)
  end
end
