class TwilioConfig < ActiveRecord::Base
  belongs_to :site
  has_many :phones, :as => :phoneable

  scope :with_incoming_phone, -> {where("(incoming_phone <> '' and incoming_phone is not null) ||  (incoming_toll_free_phone <> '' and incoming_toll_free_phone is not null)").order('updated_at desc')}


  # take out chars from mask
  before_save do |model|
    model.incoming_phone            = model.incoming_phone.to_s.gsub(/\D/,'')
    model.incoming_toll_free_phone  = model.incoming_toll_free_phone.to_s.gsub(/\D/,'')
  end  

  before_destroy do |config|
    config.remove_active_incoming_phones!
  end

  def active_phones_during_this_time
    phones.active.during_this_time
  end

  def remove_active_incoming_phones!
    if active_phone = self.class.active_phone?(incoming_phone)
     if active_phone.destroy
      update_attributes(:incoming_phone => '')
     end
    end
    if active_phone = self.class.active_phone?(incoming_toll_free_phone)
     if active_phone.destroy
      update_attributes(:incoming_toll_free_phone => '')
     end
    end 
    self.class.active_phones=nil
  end

  def self.available_numbers area_code = 210
    Twilio::AvailablePhoneNumber.all :area_code => area_code #, :contains => '3366'
  end

  def self.active_phones=phones
    @active_phones=nil
  end
  def self.active_phones
    # lp "ACTIVEPHONES" if @active_phones
    # lp "NO PHONES" unless @active_phones
    @active_phones ||= Twilio::IncomingPhoneNumber.all
  end

  def self.active_phone? phone
    return false if phone.blank?      
    active_phones.select{|ip| ip.phone_number.last(10) == phone}.first  
  end 

  def timeout 
    self.wait_duration.blank? ? 10 : self.wait_duration    
  end


  def outgoing_capability?
    self.capability_outgoing.present?
  end
end
