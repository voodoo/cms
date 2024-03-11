class InvoicePayment < ActiveRecord::Base
  belongs_to :user
  #attr_accessible :invoice_payment_type_id, :note, :user_id

  def payment_type= name
    self.invoice_payment_type_id = InvoicePaymentType.find_by_name(name).id
  end


end
