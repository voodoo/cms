class AddTwilioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twilio_active,      :boolean, :default => true
    add_column :users, :twilio_after_five,  :boolean, :default => false
    add_column :users, :twilio_before_five, :boolean, :default => false
    add_column :users, :phone, :string
    add_column :paths, :status, :integer
  end
end
