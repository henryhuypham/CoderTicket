class TicketBuyer < ActiveRecord::Base
  has_many :ticket_orders
end
