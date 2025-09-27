begin
  class UserSession < Authlogic::Session::Base
    remember_me true
    find_by_login_method :find_by_login_or_email
    extend ActiveModel::Naming
  end
rescue NameError
  # Fallback if Authlogic is not available
  class UserSession
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :login
    attribute :password
    attribute :remember_me, :boolean, default: false

    def initialize(options = {})
      super(options)
    end

    def self.find(*args); nil; end

    def save
      @user = User.authenticate(login, password)
      !!@user
    end

    def destroy; true; end
    def persisted?; false; end

    def user
      @user
    end
  end
end