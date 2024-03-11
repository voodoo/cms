class AddMetaToPages < ActiveRecord::Migration
  def change
  	add_column :boots, :meta_description, :string
  end
end
