class TicketOrder < ActiveRecord::Base
  belongs_to :ticket_buyer
  belongs_to :event
  has_many :ticket_type_orders, dependent: :destroy

  validates_presence_of :event

  def self.create_order(buyer_info, order_info, event_id)
    buyer = TicketBuyer.find_by(email: buyer_info[:email]) || TicketBuyer.create!(buyer_info)
    event = Event.find_by(id: event_id)

    ticket_type_orders = order_info.map { |type_id, quantity|
      ticket_type = TicketType.find_by(id: type_id)
      quantity = quantity.to_i

      unless ticket_type && quantity > 0
        next
      end
      if (quantity_left = ticket_type.max_quantity - ticket_type.bought_quantity) >= quantity
        ticket_type.bought_quantity += quantity
        ticket_type.save!
      else
        raise "#{ticket_type.name} only has #{quantity_left} tickets left!"
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
