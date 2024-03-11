class Layout < CmsBoot
  #belongs_to :page, :foreign_key => "layout_id"
  acts_as_list :scope => :site_id
  validates_presence_of :title, :text
end
