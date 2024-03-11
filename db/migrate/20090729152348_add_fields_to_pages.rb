class AddFieldsToPages < ActiveRecord::Migration
  def self.up
    add_column :boots, :image, :string
    add_column :boots, :thumb, :string
    add_column :boots, :price, :string
    add_column :boots, :note,  :string
  end

  def self.down
    remove_column :boots, :image
    remove_column :boots, :thumb
    remove_column :boots, :price
    remove_column :boots, :note 
  end                           
end
