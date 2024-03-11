module Twilio::CurrencyHelper
  def twilio_number_to_currency money
    currency = number_to_currency(money).sub(/^\$/,'')
    monies   = currency.split('.')
    dollars  = monies.first
    cents    = monies.last
    [dollars,'dollars', 'and', cents, 'cents'].join(' ') 
  end
end