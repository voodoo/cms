class AddTitleToUploads < ActiveRecord::Migration
  def change
  	add_column :uploads, :title, :string
  end
end
