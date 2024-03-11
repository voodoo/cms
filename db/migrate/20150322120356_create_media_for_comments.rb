class CreateMediaForComments < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :comment_id
      t.string :content_type
      t.string :url
      t.datetime :created_at
    end
  end
end
