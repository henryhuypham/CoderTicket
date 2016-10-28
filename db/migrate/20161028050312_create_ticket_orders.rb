class CreateTicketOrders < ActiveRecord::Migration
  def change
    create_table :ticket_orders do |t|
      t.references :ticket_buyer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
