class CreateTwilio < ActiveRecord::Migration
  def self.up
    create_table :twilios, :force => true do |t|
      t.integer :site_id
      t.string :api, :default => '2008-08-01'
      t.string :token
      t.string :sid
      t.string :outgoing_phone
      t.string :phone
      t.string :ii_phone
      t.string :greeting, :default => 'Thank you for calling. Connecting.'
      t.timestamps
    end    
    Site.all.map{|s| Twilio.create(:site_id => s.id) if s.twilio.nil?}   
  end

  def self.down
    drop_table :twilios
  end
end
