class Blip < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
end
