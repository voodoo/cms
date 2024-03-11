class UpdateSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :twilio_sid, :string
    add_column :sites, :twilio_token, :string
    
    add_column :sites, :email_from, :string
    add_column :sites, :email_to, :string

  end

  def self.down
    remove_column :sites, :twilio_sid
    remove_column :sites, :twilio_token
    
    remove_column :sites, :email_from
    remove_column :sites, :email_to
  end
end
