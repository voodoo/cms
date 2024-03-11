namespace :activities do
  desc "Sends daily activities"
  task daily: :environment do
    Mailer.daily_activity().deliver_now
  end
end