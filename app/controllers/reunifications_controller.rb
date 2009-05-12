class ReunificationsController < ApplicationController
  before_filter :load_child
  before_filter :build_reunification

  def create
    if @reunification.save
      flash[:notice] = t('reunifications.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def load_child
    @child = Child.find(params[:child_id])
  end

  def build_reunification
    @reunification = @child.reunifications.build(params[:reunification])
  end
end