class CreateTicketBuyers < ActiveRecord::Migration
  def change
    create_table :ticket_buyers do |t|
      t.string :name
      t.string :email, index: true

      t.timestamps null: false
    end
  end
end
