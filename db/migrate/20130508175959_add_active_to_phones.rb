class AddActiveToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :active, :boolean, :default => true
    add_column :phones, :after_five, :boolean, :default => true
    add_column :phones, :before_five, :boolean, :default => true

    add_column :sites, :owner_name, :string
  end
end
