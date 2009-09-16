class DashboardController < ApplicationController
  before_filter :require_sign_in

  layout nil

  def show
  end

  private

  def current_user
    @current_user ||= Caregiver.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def require_sign_in
    redirect_to new_session_path unless current_user
  end
end
