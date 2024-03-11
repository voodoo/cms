class CreateWhereareyous < ActiveRecord::Migration
  def self.up
    create_table :where_are_yous do |t|
      t.string   :to
      t.string   :from
      t.string   :token
      t.timestamps
    end

    create_table :where_are_you_responses do |t|
      t.integer  :where_are_you_id
      t.string   :status
      t.string   :lat
      t.string   :lng
      t.timestamps
    end    
  end

  def self.down
    drop_table :where_are_yous
    drop_table :where_are_you_responses
  end
end
