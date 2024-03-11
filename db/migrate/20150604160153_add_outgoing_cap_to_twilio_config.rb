class AddOutgoingCapToTwilioConfig < ActiveRecord::Migration
  def change
  	add_column 		:twilio_configs, 		:capability_outgoing, 			:string
    create_table :outgoing_calls, :force => true do |t|
      t.integer  :site_id
      t.integer  :contact_id
      t.integer  :user_id
      t.string   :contact_phone
      t.string   :sid
      t.string   :recording_url
      t.integer  :duration
      t.text     :paths
      t.text     :status
      t.timestamps
    end    
    add_index :outgoing_calls, :sid
    add_index :outgoing_calls, :site_id
    add_index :outgoing_calls, :contact_id
    add_index :outgoing_calls, :user_id

    add_index :incoming_calls, :sid
  end
end
