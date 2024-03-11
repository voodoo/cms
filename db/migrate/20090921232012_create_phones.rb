class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string  :number
      t.string  :name
      t.integer :site_id
      t.integer :phoneable_id
      t.string  :phoneable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
