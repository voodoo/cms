class InvoiceStatus < ActiveRecord::Base
  belongs_to :invoice, :touch => true
  belongs_to :user

  # after_create do |status|
  #   status.invoice.contact.touch
  # end

  NAMES = %w[Cancel Estimate Confirm Work Invoice Paid]  

  def self.status_id(name)
    NAMES.index(name)
  end

  def status_name
    NAMES[self.status] rescue "Sent to Contact"
  end   
 
  def self.cancel_reasons
    ["Canceled", "Unwanted", "Advised", "Found someone else", "Work already"]
  end
end
