class TerminationsController < ApplicationController
  before_filter :load_child
  before_filter :build_termination

  def create
    if @termination.save
      flash[:notice] = t('terminations.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def load_child
    @child = Child.find(params[:child_id])
  end

  def build_termination
    @termination = @child.terminations.build(params[:termination])
  end
end