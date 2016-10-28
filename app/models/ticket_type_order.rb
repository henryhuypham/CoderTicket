class TicketTypeOrder < ActiveRecord::Base
  belongs_to :ticket_order
  belongs_to :ticket_type
end
