class AddOwnerAddressToSite < ActiveRecord::Migration
  def change
  	add_column :sites, :owner_street, :string
  	add_column :sites, :owner_city, :string
  	add_column :sites, :owner_state, :string
  	add_column :sites, :owner_zip, :string
  	add_column :sites, :owner_photo, :string
  	add_column :sites, :biz_description, :string
  end
end
