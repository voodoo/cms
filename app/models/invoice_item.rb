class InvoiceItem < ActiveRecord::Base
  #attr_accessible :name, :qty, :price, :invoice_item_default_id, :note, :site_id
  has_one :attachment
  belongs_to :site
  belongs_to :invoice, :touch => true
  belongs_to :invoice_item_default
  
  has_one :product

  #validates_presence_of :name
  validates_numericality_of :price
  validates_numericality_of :qty
  validates_presence_of :invoice_item_default_id
  
  def has_attachment?
    
  end
  before_validation do |item| 
    #lp "before validation"
    if @before_invoice_item_default_id
      #lp "Setting default id in before validation"
      item.invoice_item_default_id = @before_invoice_item_default_id
    end
  end
  #money_column  :price  
  
  #validates_associated :invoice_item_default

  def name
    invoice_item_default.name
  end

  def name_plus_note
    if note.blank?
      name
    else
      name + " - " + note
    end
  end

  # def qty
  #   200
  # end
  
  def change_publishable!
    self.update_attribute(:publishable, !self.publishable)
  end
  def name= name
    self.create_new_item_default(name) unless name.blank?
  end

  def create_new_item_default name
    iid = Site.current_site.invoice_item_defaults.find_or_create_by_name(name)
    if iid.new_record?
      #lp self.inspect
      # iid.price = self.price
      # iid.qty   = self.qty
      iid.save!
    end
    lp "setting id #{iid.id} to name '#{name}'"
    @before_invoice_item_default_id = iid.id    
  end

  def sub
    self.qty * self.price.to_f
  end
  
  def tax
    self.price * self.invoice.site.tax_rate
  end
end
