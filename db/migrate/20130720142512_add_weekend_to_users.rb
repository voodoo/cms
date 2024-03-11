class AddWeekendToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :twilio_weekend, :boolean, default: false
    create_table :twilio_logs do |t|
      t.references :site
      t.string :call_sid
      t.string :call_guid
      t.text :params
      t.timestamps
    end  	
  end
end
