class CreateOutgoingCalls < ActiveRecord::Migration
  def change
    create_table :outgoing_calls do |t|
      t.integer  :site_id
      t.integer  :contact_id
      t.string   :to
      t.string   :from
      t.string   :sid
      t.integer  :duration
      t.string :recording_url
      t.timestamps
    end    
    add_index :outgoing_calls, :site_id
    add_index :outgoing_calls, :contact_id       
  end
end
