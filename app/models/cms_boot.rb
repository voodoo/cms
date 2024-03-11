# 
# * Base for pages
#
class CmsBoot < ActiveRecord::Base
  #versioned
  belongs_to :site
  self.table_name = 'boots'
end
