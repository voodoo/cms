class Tag < ActiveRecord::Base
  belongs_to :site
  has_and_belongs_to_many :contacts
  #attr_accessible :name, :category
end
