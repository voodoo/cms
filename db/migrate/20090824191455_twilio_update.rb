class TwilioUpdate < ActiveRecord::Migration
  def self.up
    rename_column :sites, :email_to, :email
    add_column :twilios, :email, :string
    add_column :twilios, :call_ii, :boolean
    add_column :twilios, :call_owner, :boolean
    add_column :twilios, :take_message, :boolean
  end

  def self.down
    rename_column :sites, :email, :email_to
    remove_column :twilios, :email
    remove_column :twilios, :call_ii
    remove_column :twilios, :call_owner
    remove_column :twilios, :take_message    
  end
end
