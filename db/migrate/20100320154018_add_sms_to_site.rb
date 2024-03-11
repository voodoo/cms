class AddSmsToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :sms, :string    
  end

  def self.down
    remove_column :sites, :sms    
  end
end
