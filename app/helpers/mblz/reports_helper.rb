module Mblz::ReportsHelper
    def to_unpaid paid_product_invoices
        paid_product_invoices.reject{|i| i.paid?}
    end
    def to_total product_invoices
        product_invoices.map{|i| i.total}.sum
    end
  
  end