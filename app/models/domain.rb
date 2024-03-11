class Domain < ActiveRecord::Base
  scoped_search :on => [:host]
  belongs_to :site
  validates_uniqueness_of :host
end