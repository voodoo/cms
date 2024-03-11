namespace :cleanup do

  desc "phone format"
  task :phones => :environment do
    ActiveRecord::Base.record_timestamps = false
    Contact.all.each do |contact|
      contact.update_attributes(:phone => contact.phone, :cell_phone => contact.cell_phone)
    end
  end
end
  