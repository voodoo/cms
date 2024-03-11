class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.integer :site_id
      t.integer :position
      t.string  :name
      t.timestamps
    end    
    
    create_table :uploads do |t|
      t.integer :site_id
      t.integer :folder_id
      t.string  :upload_file_name
      t.string  :upload_content_type
      t.string  :upload_file_size
      t.string  :upload_updated_at      
      t.timestamps
    end   
  end

  def self.down
    drop_table :uploads
    drop_table :folders
  end
end
