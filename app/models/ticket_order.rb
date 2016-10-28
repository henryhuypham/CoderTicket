class TicketOrder < ActiveRecord::Base
  belongs_to :ticket_buyer
  belongs_to :event
  has_many :ticket_type_orders, dependent: :destroy

  def self.create_order(buyer_info, order_info)
    buyer = TicketBuyer.find_by(email: buyer_info[:email]) || TicketBuyer.create!(buyer_info)
    event = Event.find_by(id: order_info[:event_id])

    ticket_type_orders = order_info.map { |type_id, quantity|
      ticket_type = TicketType.find_by(id: type_id)
      unless ticket_type
        next
      end

      TicketTypeOrder.new(ticket_type: ticket_type, quantity: quantity)
    }.compact

    TicketOrder.create!(
        ticket_buyer: buyer,
        event: event,
        ticket_type_orders: ticket_type_orders
    )
  end
end
