class CreateTicketTypeOrders < ActiveRecord::Migration
  def change
    create_table :ticket_type_orders do |t|
      t.references :ticket_order, index: true, foreign_key: true
      t.references :ticket_buyer, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
