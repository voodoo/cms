class AddSubtitleToPages < ActiveRecord::Migration

  def change
  	add_column :boots, :subtitle, :string
  end
  
end
