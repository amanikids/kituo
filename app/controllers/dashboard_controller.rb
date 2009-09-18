class DashboardController < ApplicationController
  before_filter :require_sign_in

  def show
    @scheduled_visits   = current_user.scheduled_visits.before(2.weeks.from_now).sort_by {|x| x.child.name }
    @recommended_visits = current_user.recommended_visits.sort_by {|x| x.child.name }
  end

  private

  def require_sign_in
    redirect_to new_session_path unless current_user
  end
end
