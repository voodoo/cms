class IncomingCall < ActiveRecord::Base
  scoped_search :on => [:calling, :zip]
  #acts_as_simply_searchable
  belongs_to :site
  belongs_to :contact
  belongs_to :user
  #has_many  :recordings
  serialize :session
  serialize :paths
  serialize :status
  serialize :called_phones
  
  scope :recent, -> {where("created_at > ?", 30.days.ago)}
  scope :with_message, -> { where.not(recorded_message_url: nil)}
  scope :not_released, -> { where(released_from_console: false)}
  scope :console_messages, -> { recent.with_message.not_released.limit(5) }

  after_create do |incoming|
    if contact = incoming.site.contacts.find_by_phone(incoming.calling)
      incoming.update_attribute(:contact_id, contact.id)
    end
    if user = incoming.site.users.find_by_phone(incoming.calling)
      incoming.update_attribute(:user_id, user.id)
    end
  end
  def recording
    recordings.first
  end
  def recording?
    !recordings.empty?
  end

  def release_from_console!
    self.update_attribute(:released_from_console, true)
  end
  # take out chars from mask
  before_save do |model|
    model.calling = model.calling.to_s.gsub(/\D/,'')
    model.called  = model.called.to_s.gsub(/\D/,'')
  end 

  def user_with_pin
    if self.user && self.user.pin.present?
      return user
    end
  end

  def user_with_matching_pin(pin)
    if self.user_with_pin && self.user.pin == pin
      return user
    end
  end

end
