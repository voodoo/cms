class BootCms < ActiveRecord::Migration

  def self.up
    create_users
    create_site_users
    create_boots
    create_sites
    create_domains

  end
  
  def self.down
    drop_table :sites
    drop_table :domains
    drop_table :boots
    drop_table :users
    drop_table :site_users
  end

  def self.create_boots
    create_table :boots do |t|
      t.integer :site_id
      t.integer :parent_id
      t.integer :position
      t.string  :name
      t.string  :title
      t.text    :text
      t.boolean :textile
      t.string  :type
      t.timestamps
    end 
       
  end

  def self.create_sites
    create_table "sites", :force => true do |t|
      t.string :subdomain
      t.timestamps      
    end  
    add_index :sites, :subdomain, :unique => true
    Site.create!(:subdomain => "www")
  end
  
  def self.create_domains
    create_table "domains", :force => true do |t|
      t.integer :site_id
      t.string :host
      t.timestamps      
    end    
    add_index :domains, :host, :unique => true
  end 


  def self.create_users
    create_table :users do |t|
      t.integer :role, :default => 5
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
    User.create!(:email => 'admin@bootcms.com', :password => 'boot', :password_confirmation => 'boot', :role => 0)
  end
  def self.create_site_users
    create_table :site_users do |t|
      t.references :user
      t.references :site
      t.timestamps
    end    
  end
end
