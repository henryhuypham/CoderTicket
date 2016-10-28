class TicketOrder < ActiveRecord::Base
  belongs_to :ticket_buyer
end
