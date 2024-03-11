class LeaveMessageTwilio < ActiveRecord::Migration
  def self.up
    add_column :twilios, :leave_message, :string
    add_column :twilios, :incoming_phone, :string
    add_column :twilios, :wait_duration, :integer
  end

  def self.down
    remove_column :twilios, :leave_message
    remove_column :twilios, :incoming_phone
    remove_column :twilios, :wait_duration
  end
end
