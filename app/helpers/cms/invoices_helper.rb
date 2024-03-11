module Cms::InvoicesHelper
  def default_invoice_items item
      select_tag "invoice_item[][invoice_item_default_id]", 
                 options_for_select([['-Select default-','']] + current_site.invoice_item_defaults.collect{|iid| [iid.name, iid.id]}.sort, item.invoice_item_default_id)
  end
  
end