class CreateCommentUsers < ActiveRecord::Migration
  def up
    create_table :comments_users, :id => false do |t|
       t.integer :user_id
       t.integer :comment_id
    end

    add_index :comments_users, :user_id
    add_index :comments_users, :comment_id

    add_column :comments, :to_phone, :string
    add_column :comments, :from_phone, :string


    change_column :comments, :user_id, :integer, :default => nil, :null => true

    add_column :incoming_calls, :caller_name, :string

    Comment.where(commentable_type: 'contact').each do |c| 
      c.update_attributes(commentable_type: 'Contact')
    end
    
  end

  def down

    drop_table :comments_users

    remove_column :comments, :to_phone
    remove_column :comments, :from_phone

    remove_column :incoming_calls, :caller_name

    change_column :comments, :user_id, :integer    
  end
end
