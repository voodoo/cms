class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.integer :invoice_id
      t.boolean :satisfied
      t.integer :rating
      t.text :comment
      t.boolean :confirmed_by_owner
      t.boolean :confirmed_by_customer
      t.datetime :created_at
    end

  end
end
