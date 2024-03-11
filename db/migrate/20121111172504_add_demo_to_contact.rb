class AddDemoToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :demo, :boolean, :default => false
  end
end
