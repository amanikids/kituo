class OffsiteBoardingsController < ApplicationController
  before_filter :load_child
  before_filter :build_offsite_boarding

  def create
    if @offsite_boarding.save
      flash[:notice] = "Offsite Boarding recorded for #{@child.name}."
      redirect_to @child
    else
      render :new
    end
  end

  private

  def load_child
    @child = Child.find(params[:child_id])
  end

  def build_offsite_boarding
    @offsite_boarding = @child.offsite_boardings.build(params[:offsite_boarding])
  end
end