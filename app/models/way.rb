class Way < ActiveRecord::Base
  belongs_to :site
  belongs_to :user

  validates :lat, presence: true
  validates :lng, presence: true
end
