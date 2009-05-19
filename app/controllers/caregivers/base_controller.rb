class Caregivers::BaseController < ApplicationController
  before_filter :load_caregiver

  private

  def load_caregiver
    @caregiver = Caregiver.find(params[:caregiver_id])
  end
end