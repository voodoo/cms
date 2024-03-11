class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user
      t.belongs_to :site
      t.belongs_to :contact
      t.string :action
      t.belongs_to :trackable
      t.string :trackable_type
      t.string :note

      t.timestamps
    end
    add_index :activities, :site_id
    add_index :activities, :user_id
    add_index :activities, :contact_id
    add_index :activities, :trackable_id
  end
end
