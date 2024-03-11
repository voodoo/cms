class CreateForms < ActiveRecord::Migration
  def self.up
    
    create_table :forms do |t|
      t.integer :site_id
      t.integer :position
      t.string  :name
      t.string  :title
      t.timestamps
    end  
    
    create_table :fields do |t|
      t.integer :site_id
      t.integer :form_id
      t.integer :position
      t.string  :name
      t.string  :title
      t.string  :field_type
      t.string  :value
      t.string  :options
      t.boolean :required
      t.timestamps
    end
          
  end

  def self.down
    drop_table :forms
    drop_table :fields    
  end
end
