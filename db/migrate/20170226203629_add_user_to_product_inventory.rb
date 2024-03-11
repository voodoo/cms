class AddUserToProductInventory < ActiveRecord::Migration
  def change
  	add_column :product_inventories, :user_id, :integer, default: 1
  end
end
