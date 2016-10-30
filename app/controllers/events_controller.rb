class EventsController < ApplicationController
  before_action :validate_order_param, only: [:order]
  before_action :required_login, only: [:created_by_me]

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

  def order
    validate_order_param

    @ticket_order = TicketOrder.create_order(params[:buyer], params[:tickets], params[:event_id])
    @event = @ticket_order.event

    respond_to do |format|
      format.html { render 'tickets/order_successful' }
    end
  rescue => exception
    flash[:error] = "Error: #{exception.message}"
    redirect_to :back
  end

  def created_by_me
    @events = current_user.events
  end

  private

  def search_param
    params[:search][:event_name] if params[:search].present?
  end

  def validate_order_param
    params.require(:buyer).permit(:name, :email)
    params.require(:tickets).permit!

    validate_ordered_tickets(params[:tickets])
    validate_ordered_event(Event.find_by(id: params[:event_id]))
  rescue => exception
    flash[:error] = "Error: #{exception.message}"
    redirect_to :back
  end

  def validate_ordered_tickets(order_info)
    quantity_total = order_info.reduce(0) { |sum, (_, quantity)|
      unless quantity.to_i <= 10
        raise 'You cant buy more than 10 tickets for each ticket type!'
      end
      sum + quantity.to_i
    }
    if quantity_total == 0
      raise 'Please select at least 1 ticket!'
    end
  end

  def validate_ordered_event(event)
    unless event.present?
      raise 'Event is invalid!'
    end

    unless event.starts_at >= Date.today
      raise 'Event is already over!'
    end
  end
end
