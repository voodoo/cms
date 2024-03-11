class AddWrapperToPages < ActiveRecord::Migration
  def change
  	add_column :boots, :wrapper, :string, default: "<div class='container'>{{page_content}}</div>"
  	add_column :boots, :meta_keywords, :string
  	add_column :sites, :biz_keywords, :string
  end
end
