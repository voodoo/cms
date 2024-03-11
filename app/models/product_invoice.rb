class ProductInvoice < ActiveRecord::Base

  belongs_to :user
  belongs_to :contact
  belongs_to :received_by, foreign_key: :received_by, class_name: "User"
  belongs_to :site

  has_many :product_invoice_items, :dependent => :destroy

  after_create do |product_invoice|
    product_invoice.update_attributes(tax_rate: product_invoice.site.tax_rate)
  end
  
  PAID_STATUS = ['Unpaid', 'Credit Card', 'Check', 'Cash']

  def self.todays_sales_for site
    today  = site.product_invoices.where("DATE(created_at) = ?", Date.today)
  end

  def self.sales_since site, days_ago
    site.product_invoices.where("created_at > ?", days_ago.days.ago)
  end

  def self.sales_for site, year
    site.product_invoices.where("YEAR(created_at) = ?", year)
  end

  def self.sales_by_quarter product_invoices, quarter
    product_invoices.map{|i| i.created_at.month.in?(quarter) ? i : nil}.compact
  end


  def paid_status
    PAID_STATUS[paid.to_i]
  end

  def create_items items
    for item in items
     item["price"] = item["price"].gsub(',','')
     product_invoice_items << product_invoice_items.create(item) # if they dont create they are not valid!
    end 
    update_inventory_on_product   
  end  

  def update_inventory_on_product
    self.reload
    product_invoice_items.each do |pii|
      pii.product.update_inventory
    end
  end

  def count_of_products
     product_invoice_items.map{|pi| pi.qty}.sum
  end

  def sub
    product_invoice_items.collect{|ii| ii.sub}.sum
  end
  
  def tax
    if self.taxable && self.sub > 0
      (self.sub - self.discounted) * self.site.tax_rate
    else
      0
    end
  end
  
  def discounted
    return 0 if self.discount == 0.00
    if self.discount < 1
      self.sub * self.discount
    else
      self.discount
    end
  end
  def total
    self.sub + self.tax - self.discounted
  end
end