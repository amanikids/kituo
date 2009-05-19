class Children::BaseController < ApplicationController
  before_filter :load_child
  layout 'children'

  private

  def load_child
    @child = Child.find(params[:child_id])
  end
end
