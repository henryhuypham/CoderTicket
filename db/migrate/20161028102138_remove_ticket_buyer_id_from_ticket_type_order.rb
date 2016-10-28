class RemoveTicketBuyerIdFromTicketTypeOrder < ActiveRecord::Migration
  def change
    remove_column :ticket_type_orders, :ticket_buyer_id, :integer
  end
end
