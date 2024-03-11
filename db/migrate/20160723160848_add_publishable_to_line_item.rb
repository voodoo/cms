class AddPublishableToLineItem < ActiveRecord::Migration
  def change
    add_column :invoice_items, :publishable, :boolean, default: true
  end
end
