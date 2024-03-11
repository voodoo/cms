class AddBizNameToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :biz_name, :string 
    add_column :sites, :tax_rate, :decimal, :precision => 4, :scale => 4, :default => 0.0825   
    add_column :sites, :phone, :string 
  end

  def self.down
    remove_column :sites, :biz_name 
    remove_column :sites, :tax_rate 
    remove_column :sites, :phone    
  end
end