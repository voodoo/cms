class CreatePaths < ActiveRecord::Migration
  def self.up
    create_table :paths do |t|
      t.integer :site_id
      t.string :session_id
      t.string :ip
      t.string :browser
      t.string :url
      t.string :referer
      t.text   :params
      t.timestamps
    end    
    add_index :paths, :session_id
  end

  def self.down
    #remove_index :paths, :session_id
    drop_table :paths    
  end
end
