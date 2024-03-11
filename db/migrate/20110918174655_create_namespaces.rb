class CreateNamespaces < ActiveRecord::Migration
  def self.up
    create_table :namespaces do |t|
      t.integer :site_id
      t.integer :user_id
      t.string  :permission
      t.timestamps
    end   
    for site in Site.all
      for permission in Namespace::PERMISSIONS
        Namespace.create(:site_id => site.id, :permission => permission)
      end
    end
    for user in User.all
      for permission in Namespace::PERMISSIONS
        Namespace.create(:user_id => user.id, :permission => permission)
      end
    end    
  end

  def self.down
    drop_table :namespaces
  end
end
