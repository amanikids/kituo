class CaregiversController < ApplicationController
  before_filter :build_caregiver, :only => [:new, :create]
  before_filter :load_caregiver,  :only => [:show, :edit, :update]

  def index
    @caregivers = Caregiver.by_name
  end

  def create
    if @caregiver.save
      flash[:notice] = t('caregivers.create.notice', :name => @caregiver.name)
      redirect_to caregiver_path(@caregiver)
    else
      render :new
    end
  end

  def update
    if @caregiver.update_attributes(params[:caregiver])
      flash[:notice] = t('caregivers.update.notice', :name => @caregiver.name)
      redirect_to @caregiver
    else
      render :edit
    end
  end

  private

  def build_caregiver
    @caregiver = Caregiver.new(params[:caregiver])
  end

  def load_caregiver
    @caregiver = Caregiver.find(params[:id])
  end
end