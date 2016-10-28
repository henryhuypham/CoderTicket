class AddBoughtQuantityToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :bought_quantity, :integer, default: 0
  end
end
