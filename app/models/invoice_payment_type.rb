class InvoicePaymentType < ActiveRecord::Base
  #attr_accessible :name
  def self.select_options
    all.map{|ip| [ip.name, ip.id]}
  end
end
