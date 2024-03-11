# desc "show tables that need indexing"
# task :show_indexes => :environment do
#   missing = {}
#   c = ActiveRecord::Base.connection
#   c.tables.collect do |t|
#     columns = c.columns(t).collect(&:name).select { |x| x.ends_with?  ("_id" || x.ends_with("_type")) }
#     indexed_columns = c.indexes(t).collect(&:columns).flatten.uniq
#     unindexed = columns - indexed_columns
#     missing[t] = unindexed unless unindexed.empty?
#   end
# 
#   missing.each do |table, columns|
#     columns.each do |col|
#       puts "    add_index :#{table}, :#{col}"
#     end
#   end
#   missing.each do |table, columns|
#     columns.each do |col|
#       puts "    remove_index :#{table}, :#{col}"
#     end
#   end
# end