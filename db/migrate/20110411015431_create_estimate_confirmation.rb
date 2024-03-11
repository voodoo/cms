class CreateEstimateConfirmation < ActiveRecord::Migration
  def self.up
    create_table :estimate_confirmations do |t|
      t.integer :invoice_id
      t.integer :yes_or_no
      t.string :desired_appointment_date
      t.string :details
      t.string :care_to_share
      t.timestamps
    end    
  end

  def self.down
    drop_table :estimate_confirmations
  end
end
