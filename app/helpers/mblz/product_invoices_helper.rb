module Mblz::ProductInvoicesHelper
  def select_product_invoice_items item
  	  if item.product.inactive? 
  	  	(item.product.name + " (INACTIVE) " + hidden_field_tag("product_invoice_item[][product_id]", item.product_id)).html_safe
  	  else
        select_tag "product_invoice_item[][product_id]", 
                 options_for_select([['-Select default-','']] + current_site.products.active.collect{|iid| [(iid.name + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(" + iid.size.to_s + " - " + number_to_currency(iid.price).to_s + ")").html_safe , iid.id]}.sort, item.product_id)
      end
  end
end