class EventsController < ApplicationController
  def index
    if (search_term = search_param)
      @events = Event.where('lower(name) LIKE lower(?) AND starts_at >= ?', "%#{search_term.split.join('%')}%", Date.today)
    else
      @events = Event.where('starts_at >= ?', Date.today)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def search_param
    params[:search][:event_name] if params[:search].present?
  end
end
