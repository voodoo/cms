class CreateDemos < ActiveRecord::Migration

  def up
    create_table :demos do |t|
      t.integer  :site_id
      t.integer  :user_id
      t.string   :email
      t.string   :subdomain
      t.integer  :created_by_id
      t.timestamps
    end
    clean_twilio_numbers
    for twilio_number in Twilio::IncomingPhoneNumber.all
      if incoming = TwilioConfig.find_by_incoming_phone(twilio_number.phone_number.last(10))
        incoming.update_attributes(:sid => twilio_number.sid)
      end
    end
  end
  def down
    drop_table :demos
  end
  def clean_twilio_numbers
    for number in TwilioConfig.all
      number.update_attributes(:incoming_phone => number.incoming_phone, :phone => number.phone)
    end
  end
end
