class ScheduledVisitsController < ApplicationController
  before_filter :require_sign_in

  def create
    child = Child.find(params[:child_id])
    @visit = child.scheduled_visits.create!(filter(params[:scheduled_visit]))

    respond_to do |with|
      with.json { render :json => {:id => @visit.id}, :status => :created }
      with.html { redirect_to child_path(@visit.child) }
    end
  end

  def update
    @visit = ScheduledVisit.find(params[:id])
    @visit.update_attributes(filter(params[:scheduled_visit]))

    respond_to do |with|
      with.json { head(:ok) }
      with.html { redirect_to child_path(@visit.child) }
    end
  end

  def destroy
    @visit = ScheduledVisit.find(params[:id])
    @visit.destroy
    redirect_to child_path(@visit.child)
  end

  def complete
    @visit = ScheduledVisit.find(params[:id])
    @visit.complete!
    redirect_to child_path(@visit.child)
  end

  protected

  def filter(hash)
    raise BadRequest unless hash.is_a?(Hash)

    hash.slice(:scheduled_for)
  end
end
