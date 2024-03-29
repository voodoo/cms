ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

require "authlogic/test_case"

# include :activate_authlogic # run before tests are executed
# UserSession.create(users(:whomever))


require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)
class ActiveSupport::TestCase
	#include Authlogic::Testhelper
  ActiveRecord::Migration.check_pending!
  fixtures :all
end

class Capybara::Rails::TestCase
  def sign_in_as user, pwd
    visit login_path
    fill_in 'user_session_login', :with => user
    fill_in 'user_session_password', :with => pwd
    click_button 'Log in to Mobilize'
  end
end

# # spec/support/auth_logic_helpers.rb
# module Authlogic
#   module TestHelper
#     # You can call this anything you want, I chose this name as it was similar
#     # to how AuthLogic calls it's objects and methods
#     def create_user_session(user)
#       # Assuming you have this defined in your routes, otherwise just use:
#       #   '/your_login_path'
#       post login_path, login: user.login, password: user.password
#     end
#   end
# end

# Make this available to just the request and feature specs
# RSpec.configure do |config|
#   config.include Authlogic::TestHelper, type: :request
#   config.include Authlogic::TestHelper, type: :feature
# end