class EventsController < ApplicationController
  respond_to :json

  def create
  	Event.store(event_params)
  end

  private

  def event_params
  	params.require(:event).permit(:amount, :dateTime, :fromAgent, :toAgent, :eventType)
  end
end
