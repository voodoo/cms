class CreateIncomingRecordings < ActiveRecord::Migration
  def self.up
    create_table :recordings, :force => true do |t|
      t.integer  :site_id
      t.integer  :incoming_call_id
      t.string   :url
      t.integer  :duration
      t.timestamps
    end    

  end

  def self.down
    drop_table :recordings
  end
end
