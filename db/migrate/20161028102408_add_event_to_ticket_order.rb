class AddEventToTicketOrder < ActiveRecord::Migration
  def change
    add_reference :ticket_orders, :event, index: true, foreign_key: true
  end
end
