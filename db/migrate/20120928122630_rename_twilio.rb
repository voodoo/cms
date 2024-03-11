class RenameTwilio < ActiveRecord::Migration
  def change
    rename_table 'twilios', 'twilio_configs'
  end

end
