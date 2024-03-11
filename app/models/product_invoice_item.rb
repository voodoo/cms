class ProductInvoiceItem < ActiveRecord::Base
  #attr_accessible :name, :qty, :price, :invoice_item_default_id, :note, :site_id
  #has_one :attachment
  belongs_to :site
  belongs_to :product


  validates_numericality_of :price
  validates_numericality_of :qty
  validates_presence_of :product_id  


  def sub
    self.qty * self.price.to_f
  end
  
  def tax
    self.price * self.invoice.site.tax_rate
  end
  
end
