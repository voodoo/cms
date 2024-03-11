class Namespace < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  PERMISSIONS=%w[Cms Mblz]
end