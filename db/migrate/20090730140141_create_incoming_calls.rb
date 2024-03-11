class CreateIncomingCalls < ActiveRecord::Migration
  def self.up
    create_table :incoming_calls, :force => true do |t|
      t.integer  :site_id
      t.integer  :contact_id
      t.string   :sid
      t.string   :caller
      t.string   :called
      t.string   :state
      t.string   :city
      t.string   :zip
      t.integer  :duration
      t.text     :paths
      t.text     :session
      t.text     :status
      t.timestamps
    end    
    add_index :incoming_calls, :caller
    add_index :incoming_calls, :called
  end

  def self.down
    drop_table :incoming_calls
  end
end
