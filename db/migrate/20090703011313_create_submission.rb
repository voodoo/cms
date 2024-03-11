class CreateSubmission < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.integer :form_id
      t.integer :site_id
      t.text :response
      t.string :ip
      t.timestamps
    end    
  end

  def self.down
    drop_table :submissions
  end
end
