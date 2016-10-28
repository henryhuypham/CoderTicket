class TicketBuyer < ActiveRecord::Base
  has_many :ticket_orders
  has_many :events, through: :ticket_orders
end
