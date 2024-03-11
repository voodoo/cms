class UpdateForm < ActiveRecord::Migration
  def self.up
    add_column :forms, :description, :text
    add_column :submissions, :title, :string
  end

  def self.down
    remove_column :forms, :description
    remove_column :submissions, :title
  end
end
