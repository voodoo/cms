# namespace :invoice_item do
# 
#   desc "consolidate names"
#   task :reset_defaults => :environment do
#       items = InvoiceItem.all
#       for item in items
#         set_match_for item
#       end
#   end
#   
#   desc "remove those without defaults"
#   task :clear_unused => :environment do
#     defaults = InvoiceItem.find(:all, :select => "count(1) counter, invoice_item_default_id", :group => "invoice_item_default_id")
#     defaults = defaults.map{|d| [d[:invoice_item_default_id],d[:counter].to_i]}.sort_by{|d| d.last}.reverse
#     puts defaults.inspect
#   end  
#   
#   def set_match_for item
#     name  = item.invoice_item_default.name
#     match = get_match_for(name) 
#     puts name, match, item.note
#     puts "setting item.note to #{item.note.to_s + ' ' + name}"
#     if match
#       puts "setting invoice_item_default_id to #{match.last} / #{match.first}"
#     else
#       puts "setting to general 402"
#     end
# 
#     puts   
#   end
#   def get_match_for name
#     matches = {'trim' => 1,  'remov' => 2,  'injection' => 53, 'cabl' => 65}
#     for match in matches
#       return match  if name.downcase.include?(match.first)
#     end
#     nil
#   end
# end
