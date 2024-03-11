class CreateBlips < ActiveRecord::Migration
  def change
    create_table :blips do |t|
      t.integer  :site_id
      t.integer  :user_id
      t.string   :ip
      t.string   :submission_id
      t.timestamps
    end  
  end

end
