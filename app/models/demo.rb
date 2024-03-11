class Demo < ActiveRecord::Base

  belongs_to :site
  belongs_to :user

  belongs_to :created_by ,:class_name => 'User', :foreign_key => 'created_by_id'
  validates :email, :format => { :with => RE_EMAIL,:message => "must be valid", :multiline => true }
  
  validates_uniqueness_of :email

  before_create :email_not_already_used?
  before_create :set_token

  def confirmed? demo, user
    valid_subdomain = Site.find_by_subdomain(demo[:subdomain]).nil?
    valid_user      = User.new(user.merge(:email => email, :login => email))
    if valid_subdomain && valid_user.valid?
      update_attributes(:subdomain => demo[:subdomain])
      valid_user.save!
    else 
      false
    end
  end

  def set_token
    self.token = SecureRandom.hex(12)
  end

  after_create do |demo|
    DemoMailer.send_to_email(demo).deliver
  end

  def create_site_and_user user

    user = User.new(
                email: self.email, 
                login: self.email, 
                password: user[:password], 
                password_confirmation: user[:password_confirmation])

    site = Site.new(subdomain: self.subdomain, email: self.email)

    unless user.valid?
      errors.add(:user, "is invalid")
    end

    unless site.valid?
      errors.add(:site, "is invalid")
    end    

    if user.valid? && site.valid?
      user.save
      site.save
    else
      return false
    end

    site.fake_data!
    
    if self.phone
      new_number = Twilio::IncomingPhoneNumber.create(
                    :phone_number => self.pro_phone, 
                    :voice_url => site.sub_host.concat('/twilios'))

      site.twilio_config.update_attributes(
            incoming_phone: self.phone, 
            sid: new_number.sid)
    end

    user.sites << site

    self.update_attributes! user_id: user.id, site_id: site.id

    DemoMailer.welcome(self).deliver

    TwilioConfig.active_phones=nil

    true

  end


  def email_not_already_used?
    if User.find_by_email(email)
      errors.add(:email, "is already used")
    end
  end

  def subdomain_not_already_used?
    if Site.find_by_subdomain(subdomain)
      errors.add(:subdomain, "is already used")
    end
  end


  # before_create do |demo|
  #   # Subdomain - made up randomly
  #   #demo.subdomain      = RandomStuff.subdomain
  # end


  after_destroy do |demo|
   demo.site.destroy
  end

  private

end