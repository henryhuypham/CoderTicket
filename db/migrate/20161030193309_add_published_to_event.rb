class AddPublishedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :published, :boolean, index: true, default: false
  end
end
