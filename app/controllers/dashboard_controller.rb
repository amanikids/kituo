class DashboardController < ApplicationController
  before_filter :require_sign_in

  def show
    @scheduled_visits   = current_user.scheduled_visits.before(2.weeks.from_now).sort_by {|x| x.child.name }
    @recommended_visits = current_user.recommended_visits(:limit => 4).sort_by {|x| x.child.name }

    # TODO should we show other SWs' kids in the search results?
    # Scheduling a visit for one of them would automatically switch the kid to my caseload.
    # More to think through...
    @search_results     = current_user.children.search(params[:search]).map { |child| RecommendedVisit.new(child) }
  end
end
