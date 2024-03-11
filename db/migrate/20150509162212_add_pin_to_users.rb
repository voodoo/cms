class AddPinToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :pin, :string, limit: 4
  end
end
