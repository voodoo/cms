class TwilioLog < ActiveRecord::Base
  belongs_to :site
  serialize :params
end