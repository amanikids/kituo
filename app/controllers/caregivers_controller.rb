class CaregiversController < ApplicationController
  def new
    @caregiver = Caregiver.new
  end

  def create
    @caregiver = Caregiver.new(params[:caregiver])
    if @caregiver.save
      sign_in!(@caregiver)
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
end