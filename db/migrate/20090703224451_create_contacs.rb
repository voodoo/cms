class CreateContacs < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :site_id
      
      t.string :business_name      
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      
      t.string :street
      t.string :city
      t.string :state
      t.string :zip

      t.string :email
      t.string :phone
      t.string :fax
      t.string :mobile
      t.string :sms      
      t.string :website     

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
