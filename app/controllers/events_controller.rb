class EventsController < ApplicationController
  self.subnavigation_template = 'children/subnavigation'

  before_filter :load_child

  private

  def load_child
    @child = Child.find(params[:child_id])
  end
end