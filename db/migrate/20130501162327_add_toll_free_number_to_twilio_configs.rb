class AddTollFreeNumberToTwilioConfigs < ActiveRecord::Migration
  def change
    add_column :twilio_configs, :incoming_toll_free_phone, :string
  end
end
