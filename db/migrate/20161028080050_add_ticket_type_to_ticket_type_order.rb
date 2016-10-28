class AddTicketTypeToTicketTypeOrder < ActiveRecord::Migration
  def change
    add_reference :ticket_type_orders, :ticket_type, index: true, foreign_key: true
  end
end
