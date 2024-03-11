class Style <  CmsBoot
  acts_as_list :scope => :site_id
  validates_presence_of :title, :text
end
