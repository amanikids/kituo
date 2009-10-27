class EventsController < ApplicationController
  before_filter :find_event

  def update
    @event.update_attributes(params[:event])
    redirect_to @event.child
  end

  def destroy
    @event.destroy
    redirect_to @event.child
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end
end
