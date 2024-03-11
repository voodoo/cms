class Dsp < ActiveRecord::Base
  belongs_to :site
  has_many :dsp_responses
end
