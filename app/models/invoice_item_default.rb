class InvoiceItemDefault < ActiveRecord::Base
  #attr_accessible :name, :qty, :price, :invoice_item_default_id, :note, :site_id

  belongs_to :site
  has_many :invoice_items
  validates_presence_of :name
  #validates_numericality_of :price
  #validates_numericality_of :qty
  #money_column  :price  
  
  def self.select_options
   $ITE.invoice_item_defaults.collect{|iid| [iid.name, iid.id]}
  end
  
  # Count how many each default item is used (include zero)
  def self.counts(site_id)
    sql = %Q{
      select id, 
      (select count(1) from invoice_items where invoice_item_default_id = iid.id and site_id=#{site_id}) as counter 
      from invoice_item_defaults iid where site_id = #{site_id}     
    }
    self.find_by_sql(sql).map{|d| [d.id, d.counter.to_i]}
  end

  def self.that_are_empty(site_id)
    counts(site_id).reject{|c| !c.last.zero?}.map{|c| InvoiceItemDefault.find(c.first)}
  end

  # Clear the default item if it is not used
  def self.clear_empty!(site_id)
    puts "clearing empty "
    that_are_empty(site_id).each do |ii|
      puts "default item #{ii.first} is going to be deleted"
    end
  end
end
