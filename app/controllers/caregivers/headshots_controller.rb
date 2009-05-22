class Caregivers::HeadshotsController < Caregivers::BaseController
  def update
    if @caregiver.update_attributes(params[:caregiver])
      flash[:notice] = t('caregivers.headshot.update.notice', :name => @template.link_to(@caregiver.name, @caregiver))
      redirect_to @caregiver
    else
      render :edit
    end
  end
end