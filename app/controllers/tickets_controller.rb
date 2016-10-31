class TicketsController < ApplicationController
  before_action :required_login, only: [:create_type]

  def new
    @event = Event.find(params[:event_id])
  end

  def create_type
    @event = Event.find(params[:event_id])

    unless request.post?
      return
    end

    ticket_type = TicketType.new(create_type_param)
    ticket_type.event = @event
    ticket_type.save!

    flash[:success] = 'Ticket type created successfully'
    redirect_to event_path(@event)
  end

  private

  def create_type_param
    params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end
end
