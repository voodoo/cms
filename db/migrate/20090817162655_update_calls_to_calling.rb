class UpdateCallsToCalling < ActiveRecord::Migration
  def self.up
    rename_column :incoming_calls, :caller, :calling
  end

  def self.down
    rename_column :incoming_calls, :calling, :caller
  end
end
