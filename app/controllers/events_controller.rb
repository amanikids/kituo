class EventsController < ApplicationController
  def update
    @event = Event.find(params[:id])
    @event.update_attributes!(params[:event])
    redirect_to @event.child
  end
end
