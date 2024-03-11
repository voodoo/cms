class AddCaptcha < ActiveRecord::Migration
  def change
  	add_column :sites, :captcha_site, :string
  	add_column :sites, :captcha_secret, :string
  end
end
