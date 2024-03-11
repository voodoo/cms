class Site < ActiveRecord::Base
  cattr_accessor :current_site

  
  authenticates_many :user_sessions
  
  scoped_search :on => [:subdomain, :biz_name]

  belongs_to :copied_from, :class_name => 'Site', :foreign_key => 'copied_site_id'

  validates_uniqueness_of :subdomain
  validates_format_of :email,   :with => RE_EMAIL, :allow_blank => true, :multiline => true

  has_one :demo, dependent: :destroy
  has_one  :twilio_config,  :dependent => :destroy
  has_many :twilio_logs, -> {order(created_at: :desc)}
  has_many :tags
  
  has_many :blips
  has_many :outgoing_calls
  has_many :permissions
  has_many :namespaces
  has_many :activities, -> { order(created_at: :desc)} , dependent: :delete_all
  has_many :site_users
  has_many :users,    :through => :site_users
  has_many :uploads
  has_many :folders, -> {order(:position).includes(:uploads)}
  has_many :contacts,  :dependent => :destroy#, :order => 'created_at desc'
  has_many :incoming_calls,  :dependent => :destroy
  has_many :forms, -> {order(:position)}
  has_many :fields,  :dependent => :destroy
  has_many :submissions, -> {order(created_at: :desc)} 
  has_many :faqs, -> {order(:position)}
  has_many :domains,  :dependent => :destroy
  has_many :pages,    :dependent => :delete_all
  has_many :ways
  
  has_many :styles,  -> {order(:position)},  :dependent => :destroy

  has_many :layouts,   -> {order(:position)}, :dependent => :destroy
  has_many :comments
  has_many :paths, -> {order(created_at: :desc)},:dependent => :destroy
  has_many :dsps
  has_many :invoices# shit, this cant be overridden?, :order => 'invoices.updated_at desc'
  has_many :invoice_item_defaults, :dependent => :destroy
  has_many :invoice_items
  has_many :products, -> {order(:name)}
  has_many :product_categories

  has_many :product_invoices,  -> {order(created_at: :desc)},:dependent => :destroy
  has_many :product_inventories, -> {order(created_at: :desc)},:dependent => :destroy


  # take out chars from mask
  before_save do |model|
    model.phone            = model.phone.to_s.gsub(/\D/,'')
  end  

  after_create do |site|

    # Copy a previous site
    if copied_site = site.copied_from
      layout = site.layouts.create!(
          :text => copied_site.layouts.first.text, 
          :title => "Default")
      Page.copy_pages(copied_site.root_page, site, nil)
      site.styles.create!(
          :text =>   copied_site.styles.first.text, :title => "Default")
    else
      # Or accept default  stuff
      layout = site.layouts.create!(
          :text => render_fixture_file('layout', :html), 
          :title => "Default")
      site.pages.create!(:text =>   "Hello, #{site.subdomain}", 
          :title => "Hello world", 
          :textile => true, :layout_id => layout.id)
      site.styles.create!(
          :text =>   render_fixture_file('style', :css), :title => "Default")
    end

    # Add admin to all sites
    site.users << User.find(1)

    # incoming call handling
    TwilioConfig.create(:site_id => site.id, :email => site.email,
                  :leave_message => "Please leave a message",
                  :greeting => "Thank you for calling",
                  :wait_duration => 7)

    # Default Contact form
    site.create_default_form!
    
    contact_yml           = YAML.load(File.read(Rails.root.join('app/views/admin/sites/fixtures/contacts.yml')))
    contact               = site.contacts.create(contact_yml)
    invoice               = contact.invoices.create(:site_id => site.id, user_id: 1)
    invoice_item_default  = site.invoice_item_defaults.create!(:name => "Services")
    invoice_item_default  = site.invoice_item_defaults.create!(:name => "Product")
    invoice.invoice_items.create(:invoice_item_default_id => invoice_item_default.id, :qty => 2, :price => '100.00')

  end

  before_destroy do
    for user in self.users
      if user.deletable?
        user.destroy
      end
    end
    self.demo.destroy if self.demo
  end

  def contacts_for_phone_console
    contacts = self.contacts.with_priority.limit(5)  
    #unseen   = self.invoices.unseen_by_owner.limit(10 - contacts.size).map{|i| i.contact} 
    #(contacts + unseen).uniq   
  end

  def unreleased_messages
    contacts = self.incoming_calls.limit(5)  
  end

  def to_s
    subdomain  
  end

  def tag_categories
    tags.group('category').map &:category
  end


  def create_default_form!
    form = self.forms.create!(title: "Contact")
    %w[First_Name Last_Name Email Phone Street City State Zip More].each do |field|
     form.fields.create(
        :title => field, 
        :field_type => 'Text', 
        :required => field != 'More')
    end 
    form   
  end  

  def callable_phones
   phones = []
   if self.twilio_config.call_owner? and !self.phone.blank?
     phones << self.phone
   end

   # for phone in self.twilio_config.active_phones_during_this_time
   #   phones << phone.number
   # end

   for user in self.active_twilio_users_during_this_time
     phones << user.phone
   end   

   if twilio_config.call_ii?
     phones << APP_CONFIG[:phone]
   end    
   phones.compact.map(&:to_twilio_phone)
  end

  def active_twilio_users_during_this_time

    check_weekend = ''

    now = Time.now.utc.getlocal('-05:00')


    if now.saturday? || now.sunday? # if currentlly the weekend, make sure weekend is checked
      check_weekend = 'and twilio_weekend = true'
    end

    before_or_after = now.hour >= 17 ? "after" : "before"
    self.users.where("active = true and twilio_active = true and twilio_#{before_or_after}_five = true #{check_weekend}")

  end

  def self.host_path request, subdomain, path
    
  end

  def accepts_paypal?
    self.paypal? && !self.paypal_email.blank?  
  end

  def has_blip_with_ip?(ip)
    self.blips.where("ip = ?", ip).count > 0
  end

  def fake_data!
    (1..10).each do |i|
      contact = self.contacts.create!(:first_name => Faker::Name.first_name,
                            :last_name  => Faker::Name.last_name,
                            :phone      => Faker::PhoneNumber.phone_number,
                            :email      => Faker::Internet.email,
                            :street     => Faker::Address.street_name,
                            :city       => Faker::Address.city,
                            :state      => 'Texas',
                            :zip        => Faker::Address.zip_code,
                            :demo       => true)


      invoice = contact.invoices.create!(:site_id => self.id, user_id: 1)
      1.upto(rand(10)) do |i|
        # Site did not have invoice defaults so add one
        if invoice_item_defaults.empty?
          invoice_item_defaults.create!(:name => "Services")
        end
        invoice_item_default  = self.invoice_item_defaults.all.shuffle.first
        invoice.invoice_items.create(:invoice_item_default_id => invoice_item_default.id,
                                      :qty => rand(5) + 1, :price => rand(1000), :note => Faker::Lorem.sentence)
      end
    end
  end

  def clear_fake_data!
    fakers = self.contacts.where('demo=true').each{|c|c.destroy}
  end

  # def domain_host
  #    "https://#{domains.first.host}"
  # end

  def host_or_subdomain
    if self.domains.present?
      self.domains.first.host
    else
      "#{self.subdomain}.#{Rails.env.production? ? 'mblz.com' : 'cms.dev'}"
    end
  end

  def host
    "#{subdomain}.mblz.com"  
  end


  def sub_host
    host = Rails.env.production? ? 'mblz.com' : 'cms.dev'
    "https://#{self.subdomain}.#{host}"
  end  



  def create_user(user)
    @user = User.new(user)
    if @user.save
      self.site_users.create(:user_id => @user.id)
      return @user
    end
  end

  def layout_options
    layouts.map{|l| [l.title, l.id]}
  end

  def root_page
    pages.find_by_parent_id(nil)
  end
  def default?
    self.subdomain == 'www'
  end

  def mblz?
    self.id == 1
  end
  def self.search q
    all(:conditions => "subdomain like '%#{q}%'")
  end

  def has_permission?(permission)
    self.permissions.find_by_module(permission)
  end

  def update_namespace perm
    if permission = namespaces.find_by_permission(perm)
      permission.destroy
    else
      namespaces.create!(:permission => perm)
    end
  end
  protected

  def render_fixture_file name, handler
    view = ActionView::Base.new(ActionController::Base.view_paths, {})
    view.render(:file => "#{Rails.root}/app/views/admin/sites/fixtures/#{name}", :locals => {:site => self.subdomain}, :handlers => [handler] )
  end

end