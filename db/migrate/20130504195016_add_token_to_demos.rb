class AddTokenToDemos < ActiveRecord::Migration
  def change
    add_column :demos, :token, :string
    add_column :demos, :phone, :string
    add_column :demos, :pro_phone, :string
  end
end
