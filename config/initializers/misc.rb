#Haml::Template.options[:format] = :html5

REALLY = "Are you sure?" #unless defined?(REALLY)
BLANK  = '[n/a]'
# loud puts
def lp message
  logger.warn "\\"*10
  logger.warn message
  logger.warn '/'*10
end

require 'ostruct'

ASSETS_HOST = 'http://assets.integrated-internet.com'

def assets_host
	Rails.env.development? ? "http://localhost:3000/" : 'http://mblz.mblz.com/'
end