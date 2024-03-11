class Path < ActiveRecord::Base
  belongs_to :site
  serialize :params, JSON
  scoped_search :on => [:browser, :url, :referer, :ip]
  def self.remote_refs(site, host)
    find(:all, :conditions => "site_id = #{site} and referer not like 'https://#{host}%' and referer is not null", :limit => 10, :order => 'created_at desc')
  end
end
