class EventsController < ApplicationController
  before_action :check_order_param, only: [:order]

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
    check_order_param

    @ticket_order = TicketOrder.create_order(params[:buyer], params[:tickets])
    @event = @ticket_order.event

    respond_to do |format|
      format.html { render 'tickets/order_successful' }
    end
  end

  private

  def search_param
    params[:search][:event_name] if params[:search].present?
  end

  def check_order_param
    begin
      params.require(:buyer).permit(:name, :email)
      params.require(:tickets).permit!

      quantity_total = params[:tickets].reduce(0) { |sum, (_, quantity)|
        sum + quantity.to_i
      }
      if quantity_total == 0
        raise 'Please select at least 1 ticket!'
      end
    rescue => exception
      flash[:error] = "Error: #{exception.message}"
      redirect_to :back
    end
  end
end
