class CreateTaggable < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :site_id
      t.string :category
      t.string :name
      t.datetime :created_at
    end

    create_table :contacts_tags, id: false do |t|
      t.references :tag
      t.references :contact
    end

    add_index :tags, :site_id
    add_index :contacts_tags, :tag_id
    add_index :contacts_tags, :contact_id

    site = Site.find_by_subdomain 'handy'
    Date::DAYNAMES.each do |name|
      site.tags.create(name: name, category: 'Recurring')
    end
    
    site = Site.find_by_subdomain 'canopy'
    %w[Commercial Residential].each do |name|
      site.tags.create(name: name, category: 'Profile')
    end

    
  end

  def self.down
    drop_table :contacts_tags
    drop_table :tags
  end

end

