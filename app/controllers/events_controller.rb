class EventsController < ApplicationController
  def index
    @events = Event.where('starts_at >= ?', Date.today)
  end

  def show
    @event = Event.find(params[:id])
  end
end
