class SessionsController < ApplicationController
  def new
    @caregivers = Caregiver.by_name
  end

  def create
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
