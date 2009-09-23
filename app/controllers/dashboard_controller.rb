class DashboardController < ApplicationController
  before_filter :require_sign_in

  def show
    case current_user.role
    when 'social_worker'
      @scheduled_visits   = current_user.scheduled_visits.before(2.weeks.from_now).sort_by {|x| x.child.name }
      @recommended_visits = current_user.recommended_visits(:limit => 4).sort_by {|x| x.child.name }

      # TODO should we show other SWs' kids in the search results?
      # Scheduling a visit for one of them would automatically switch the kid to my caseload.
      # More to think through...
      @search_results     = current_user.children.search(params[:search]).map { |child| RecommendedVisit.new(child) }
      render 'social_worker'
    when 'development_officer'
      @children_requiring_headshots = Child.by_name.find_all_by_headshot_file_name(nil)
      render 'development_officer'
    else
      raise "Unknown caregiver role: #{current_user.inspect}"
    end
  end
end
