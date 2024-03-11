class ChangeAnsweredByColToString < ActiveRecord::Migration
  def up
  	change_column(:incoming_calls, :answered_by, :string)
  end

  def down
  	change_column(:incoming_calls, :answered_by, :integer)
  end
end
