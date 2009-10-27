class CaregiversController < ApplicationController
  def new
    @caregiver = Caregiver.new(params[:caregiver])
  end

  def create
    @caregiver = Caregiver.new(params[:caregiver])
    if @caregiver.save
      sign_in!(@caregiver)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @caregiver = Caregiver.find(params[:id])
  end

  def update
    @caregiver = Caregiver.find(params[:id])
    if @caregiver.update_attributes(params[:caregiver])
      redirect_to root_path
    else
      render 'new'
    end
  end
end