class ChangeInvoiceStatus < ActiveRecord::Migration
  # Accomodate for 'Cancelled' - now the first status
  def up
    change_by(1)
      
  end

  def down
    change_by(-1)
  end

  def change_by(increment_or_decrement)
    Invoice.all.each do |invoice|
      if !invoice.paid.nil?
        #p "was paid #{invoice.contact.full_name}"
        created = invoice.paid
      else
        created = invoice.updated_at
      end
      after = invoice.status + increment_or_decrement
      Invoice.update_all("status = #{after}", "id = #{invoice.id}")
      invoice.invoice_statuses.create!(:status => after, :created_at => created)
    end   
  end
end
