class Contact < ActiveRecord::Base
  require 'csv'
  scope :recent, lambda {where("created_at > ?", 30.days.ago)}
  scope :with_priority, lambda {where("priority <> 0").limit(10).order(updated_at: :desc)}

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def geocode!
    return if self.geocoded?
    # force geocode gem to update
    self.update_attributes(updated_at: Time.now)
  end

  def self.geocode_all!(contacts)
    contacts.each(&:geocode!)
    contacts.select{|c| c.geocoded? }.uniq
  end

  has_and_belongs_to_many :tags
  
  PRIORITY = [
    {name: 'None', theme: nil},
    {name: 'Info', theme: 'b'},
    {name: 'Alert', theme: 'e'},
    {name: 'Emergency', theme: 'r'}
  ]

  has_many :activities
  scoped_search :on => [:first_name, :last_name, :phone, :zip, :business_name, :street, :email]

  # belongs_to :contactable, :polymorphic => true
  # has_many :contacts, :as => :contactable
  belongs_to :submission
  belongs_to :site

  has_many :incoming_calls
  has_many :outgoing_calls

  has_many :invoices, :dependent => :destroy
  
  has_many :product_invoices, :dependent => :destroy

  validates_presence_of :phone, :email, :city, :street, :state, :first_name, :last_name

  has_many :comments,:dependent => :destroy
  acts_as_commentable


  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  
  # take out chars from mask
  before_save do |contact|
    contact.phone       = contact.phone.to_s.gsub(/\D/,'')
    contact.other_phone = contact.other_phone.to_s.gsub(/\D/,'')
    contact.cell_phone  = contact.cell_phone.to_s.gsub(/\D/,'')
  end  

  def priority_name
    PRIORITY[self.priority][:name]
  end

  def release_priority!
    self.update_attribute(:priority, 0)
  end
  def self.select_options
    $ITE.contacts.collect{|c| [c.full_name, c.id]}
  end

  def biz_or_name
    self.business_name.blank? ? self.full_name : self.business_name
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def initials
    [first_name, middle_name, last_name].map{|s| s.first}.compact.join('').upcase
  end

  def last_name_first
   [ last_name, ', ', first_name, ' ',  middle_name.to_s.first].join('')
  end

  def full_address
    a = []
    a << business_name unless business_name.blank?
    a << full_name
    a << street
    a << "#{city}, #{state} #{zip}"
    a << email unless email.blank?
    a << phone unless phone.blank?
    a.join("\n")
  end

  def address
    "#{street} #{city}, #{state} #{zip}"
  end

  def phoned
    self.phone.to_phone unless phone.blank?
  end

  def create_comment user, site, title, comment
    self.comments.create!(:user_id => user.id, :site_id => site.id, :title => title, :comment => comment)
  end

  def self.export_all(site)
    contacts = site.contacts
    export = CSV.generate do |csv|
      csv << %w[name biz_name email phone street city state zip created_at]
      contacts.each do |c|
        csv << [c.full_name, c.business_name, c.email, c.phone, c.street, c.city, c.state, c.zip, c.created_at.to_s(:long)]
      end
    end
    export
  end

  def vcard
    Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
      name.given = self.full_name
      end

      maker.add_addr do |addr|
        addr.location = 'home'
        addr.street = self.street
        addr.locality = self.city
        addr.region = self.state
        addr.postalcode = self.zip
      end
      maker.add_email(self.email)
      maker.add_tel(self.phone)

      unless self.comments.empty?
        comments = []
        for comment in self.comments
          comments << [comment.title, comment.comment].join("::")
        end
        maker.add_note comments.join("\n\n") + "\n\n"
      end
    end.to_s
  end
end
