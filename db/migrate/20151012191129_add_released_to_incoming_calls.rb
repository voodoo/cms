class AddReleasedToIncomingCalls < ActiveRecord::Migration
  def change
  	add_column :incoming_calls, :released_from_console, :boolean, default: false
  end
end
