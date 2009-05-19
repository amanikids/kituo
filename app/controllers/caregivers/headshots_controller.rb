class Caregivers::HeadshotsController < Caregivers::BaseController
  def update
    if @caregiver.update_attributes(params[:caregiver])
      flash[:notice] = t('caregivers.headshot.update.notice', :name => @caregiver.name)
      redirect_to @caregiver
    else
      render :edit
    end
  end
end