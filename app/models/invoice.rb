class Invoice < ActiveRecord::Base
  before_create :set_token
  acts_as_commentable

  has_one :review, :dependent => :destroy


  belongs_to :user
  belongs_to :received_by, foreign_key: :received_by, class_name: "User"
  belongs_to :site
  belongs_to :contact

  has_many :invoice_items, :dependent => :destroy
  has_many :estimate_confirmations, :dependent => :destroy
  has_many :invoice_statuses, :dependent => :destroy
  has_many :attachments
  has_many :invoice_payments


  scope :by_year_month_and_status, lambda {|site, year, month, status| 
      where("invoices.site_id = :site_id and YEAR(invoices.created_at) = :year  and Month(invoices.created_at) = :month and status = :status", 
        site_id: site.id, month: month.to_i, year: year, status: status)
        .joins(:contact)}

  scope :recent, lambda {where("created_at > ?", 30.days.ago)}
  scope :unseen_by_owner, lambda {where(received_by: nil).order(updated_at: :desc)}
  
  
  def dupe(user)
    duped = Invoice.create!(
        contact_id: contact_id,
        site_id: site_id,
        footer: footer,
        taxable: taxable,
        user_id: user.id,
        tax_rate: tax_rate
        )  
    invoice_items.each do |item|
      duped.invoice_items.create!(
          qty: item.qty, 
          price: item.price, 
          invoice_item_default_id: item.invoice_item_default_id,
          note: item.note
      )
    end

    duped
  end
  
  after_create do |invoice|
    # Set default status to Estimate
    invoice.update_attributes(status: 1)
    invoice.invoice_statuses.create!(user_id: self.user_id, status: 1)
    # Pin tax rate to invoice
    invoice.update_attributes(tax_rate: invoice.site.tax_rate)
    # Send the invoice to the owner of the site
    send_new_estimate_to_owner(invoice)
  end
  



  def public_link
    if Rails.env.development?
      host = 'localhost:4567'
    else
      host = 'www.' + self.site.domains.first.host
    end

    "https://#{host}/invoice?t=#{self.token}"
  end

  def paid_with_paypal?
    type_id = InvoicePaymentType.find_by_name('Paypal').id
    invoice_payments.find_by_invoice_payment_type_id(type_id)
  end

  def needs_work_date?
    status_name == 'Work' && work_date.nil? 
  end

  # Invoice is in 'Work' status and has a date
  def in_work?
    status_name == 'Work' && !work_date.nil?
  end

  def self.to_csv year, month, status
    require 'csv'
    invoices = Invoice.by_year_month_and_status(year, month, status)    
    output = CSV.generate do |csv|
      csv << ["name", "address", "invoice", "amount", "created_at"]
      invoices.each do |invoice|
        csv << [invoice.contact.full_name,invoice.contact.address, invoice.id, invoice.total, invoice.created_at]
      end
    end    
    output 
  end
  def current_status
    self.invoice_statuses.last
  end
  def status_name
    InvoiceStatus::NAMES[self.status]
  end 
    
  def or_estimate
    ['Paid', 'Invoice'].include?(self.status_name) ? 'Invoice' : 'Estimate'
  end
   
   def estimate? # not an invoice yet
    self.status_name == 'Estimate'
   end
   
   def paid?
    self.status_name == 'Paid'
   end

   def invoiced?
    self.status_name == 'Invoice'
   end

  def confirmed_at_least?
    self.status >= InvoiceStatus.status_id('Confirm')  
  end

  def set_token( length = 8 )
    self.token = SecureRandom.hex(8)
  end
  
  def sub
    invoice_items.collect{|ii| ii.sub}.sum
  end
  
  def tax
    self.taxable? ? (self.sub * self.site.tax_rate) : 0.00
  end
  
  def total
    self.sub + self.tax
  end
  
  def create_items items
    for item in items
     item["price"] = item["price"].gsub(',','')
     #p item
     pitem = item.merge({:site_id => Site.current_site.id})
     invoice_items << invoice_items.create(pitem) # if they dont create they are not valid!
    end    
  end

  def token_url
    "https://#{self.site.host}/invoice/#{self.token}"
  end
  
  def price
    invoice_items.sum(:price)
  end
  
  def increase_view_count
    self.update_attribute( :view_count, self.view_count + 1 )
  end

  def self.export_all(site)
    invoices = site.invoices.includes(:contact)
    export = CSV.generate do |csv|
      csv << %w[contact biz_name email phone street city state zip contact_created_at invoice_number invoice_status invoice_total]
      invoices.each do |i|
        c = i.contact
        csv << [c.full_name, c.business_name, c.email, c.phone, c.street, c.city, c.state, c.zip, c.created_at.to_s(:long), i.id, i.status_name, sprintf('%.2f',i.total)]
      end
    end
    export
  end

  protected

  def send_new_estimate_to_owner(invoice)
    # Don't send to owner if owner is creating
    if  !invoice.user.owner?
      phone = Owner.phone(invoice.site)
      unless phone.blank?
        url = "https://#{invoice.site.host}/mblz/invoices/#{invoice.id}"
        if site.twilio_config.incoming_phone.present? && !(Rails.env.development? || Rails.env.test?) #TODO user twilio test number for this
          Twilio::SMS.create :from =>  site.twilio_config.incoming_phone, :to => phone, :body => "New Estimate for: #{invoice.contact.full_name}\n\n#{url}"
        else
          logger.info("Twilio: send_new_estimate_to_owner : incoming phone = #{site.twilio_config.incoming_phone}, to = #{phone}")
        end
      end
    end
  end

end
