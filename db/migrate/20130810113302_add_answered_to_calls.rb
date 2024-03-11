class AddAnsweredToCalls < ActiveRecord::Migration
  def change
  	add_column :incoming_calls, :answered_by, :integer
  	add_column :incoming_calls, :called_phones, :text
  end
end
