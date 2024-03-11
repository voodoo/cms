class User < ActiveRecord::Base
  scoped_search :on => [:email, :login]

  # Handled by AAA?
  # validates_uniqueness_of :login
  # validates_uniqueness_of :email


  ROLES = {Admin: 0, Owner: 1, Manager: 3, User: 5}

  has_many :permissions
  has_many :namespaces
  has_many :activities
  has_many :ways

  has_many :invoices

  # take out chars from phone
  before_save do |c|
    c.phone      = c.phone.to_s.gsub(/\D/,'').last(10)
  end

  # acts_as_authentic do |c|
  #   c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  # end # block optional
  
  acts_as_authentic do |c|
    #logger "got in actsa"
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    #c.transition_from_crypto_providers = [Authlogic::CryptoProviders::Sha512]
    #c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end




  has_and_belongs_to_many :comments

  def deletable?
    self.sites.size == 1 && !self.admin?
  end

  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end

  has_many :site_users
  #has_many :sites
  has_many :sites, :through => :site_users
  #has_one  :contact
  has_many :comments
  liquid_methods :email, :role, :admin?

  def login_or_email
    self.login || self.email
  end

  def has_permission?(permission)
    self.permissions.find_by_module(permission)
  end

  def update_namespace perm
    if permission = namespaces.find_by_permission(perm)
      permission.destroy
    else
      namespaces.create!(:permission => perm)
    end
  end

  def self.options_for_role_select
    ROLES.map{|k,v| [k, v]}
  end

  def role_name
    ROLES.key(self.role)
  end
  def admin?
    self.role == 0
  end

  def owner?
    self.role == 1
  end

  def owner_or_above?
    self.role == 1 || self.role == 0
  end
  
  def manager?
    self.role == 3
  end

end