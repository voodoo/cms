class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :site_id
      t.integer :user_id
      t.string  :module
      t.timestamps
    end   
    for site in Site.all
      for permission in Permission::MODULES
        Permission.create(:site_id => site.id, :module => permission)
      end
    end
    for user in User.all
      for permission in Permission::MODULES
        Permission.create(:user_id => user.id, :module => permission)
      end
    end    
  end

  def self.down
    drop_table :permissions
  end
end
