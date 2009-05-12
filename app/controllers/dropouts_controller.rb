class DropoutsController < ApplicationController
  before_filter :load_child
  before_filter :build_dropout

  def create
    if @dropout.save
      flash[:notice] = t('dropouts.create.notice', :name => @child.name)
      redirect_to @child
    else
      render :new
    end
  end

  private

  def load_child
    @child = Child.find(params[:child_id])
  end

  def build_dropout
    @dropout = @child.dropouts.build(params[:dropout])
  end
end
