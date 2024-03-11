class CreateWays < ActiveRecord::Migration

	def up
    create_table :ways do |t|
      t.integer :user_id
      t.integer :site_id
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :message
      t.datetime :created_at
    end  
    drop_table :where_are_you_responses
    drop_table :where_are_yous			
	end
  def down
    drop_table :ways
    create_table :where_are_you_responses
    create_table :where_are_yous	
  end
end
