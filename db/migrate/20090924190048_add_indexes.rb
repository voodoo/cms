class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :uploads, :site_id
    add_index :uploads, :folder_id
    add_index :submissions, :form_id
    add_index :submissions, :site_id
    add_index :faqs, :site_id
    add_index :boots, :site_id
    add_index :boots, :parent_id
    add_index :boots, :layout_id
    add_index :comments, :site_id
    add_index :comments, :commentable_id
    add_index :fields, :site_id
    add_index :fields, :form_id
    add_index :forms, :site_id
    add_index :domains, :site_id
    add_index :site_users, :user_id
    add_index :site_users, :site_id
    add_index :recordings, :site_id
    add_index :recordings, :incoming_call_id
    add_index :incoming_calls, :site_id
    add_index :incoming_calls, :contact_id
    add_index :twilios, :site_id
    add_index :paths, :site_id
    add_index :permissions, :site_id
    add_index :permissions, :user_id
    add_index :contacts, :site_id
    add_index :phones, :site_id
    add_index :phones, :phoneable_id
    add_index :folders, :site_id

  end

  def self.down
    remove_index :uploads, :site_id
    remove_index :uploads, :folder_id
    remove_index :submissions, :form_id
    remove_index :submissions, :site_id
    remove_index :faqs, :site_id
    remove_index :boots, :site_id
    remove_index :boots, :parent_id
    remove_index :boots, :layout_id
    remove_index :comments, :site_id
    remove_index :comments, :commentable_id
    remove_index :fields, :site_id
    remove_index :fields, :form_id
    remove_index :forms, :site_id
    remove_index :domains, :site_id
    remove_index :site_users, :user_id
    remove_index :site_users, :site_id
    remove_index :recordings, :site_id
    remove_index :recordings, :incoming_call_id
    remove_index :incoming_calls, :site_id
    remove_index :incoming_calls, :contact_id
    remove_index :twilios, :site_id
    remove_index :paths, :site_id
    remove_index :permissions, :site_id
    remove_index :permissions, :user_id
    remove_index :contacts, :site_id
    remove_index :phones, :site_id
    remove_index :phones, :phoneable_id
    remove_index :folders, :site_id
  end
end
