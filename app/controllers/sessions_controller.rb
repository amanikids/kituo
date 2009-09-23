# We don't require a password for sign in - since everyone can do anything
# anyways. It's in your own best interest to sign in because then you see
# a dashboard that is tailored for you.
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
