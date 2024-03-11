class CreateProducts < ActiveRecord::Migration

  SITE_ID=62
  def change

    create_table :products do |t|
      t.integer :site_id

      t.integer :product_category_id

      t.string :name
      t.string :size

      t.decimal :price, :precision => 10, :scale => 2, :default => 0.0   

      t.string :color
      t.integer :sun
      t.integer :water
      t.string :height
      t.string :tolerance
      
      t.integer :inventory, default: 0
      t.integer :location
      t.string :note

      t.string   :image_file_name
      t.string   :image_content_type
      t.string   :image_file_size
      
      t.timestamps null: false
    end

    create_table :product_categories do |t|
      t.integer :site_id
      t.string :name
      t.string :matrix
      t.string :color
      t.string :html_color
    end

    create_table :product_inventories do |t|
      t.integer :site_id
      t.string :note
      t.timestamps null: false
    end

    create_table :product_inventory_items do |t|
      t.integer :product_inventory_id
      t.integer :product_id
      t.integer :projected_count
      t.integer :actual_count
      t.string :note
    end

    create_table :product_invoices do |t|
      t.integer :site_id
      t.integer :user_id
      t.string :note
      t.boolean :taxable, default: false
      t.string :footer, default: "Thank you for your business"
      t.timestamps null: false
    end

    create_table :product_invoice_items do |t|
      t.integer :product_invoice_id
      t.integer :product_id
      
      t.decimal :price, :precision => 10, :scale => 2, :default => 0.0     
      t.integer :qty      
    end




    ProductCategory.create(name: "Palms", site_id: SITE_ID, matrix: '3x3', color: :red, html_color: :firebrick)  
    ProductCategory.create(name: "Trees", site_id: SITE_ID, matrix: '20x1', color: :green, html_color: :green) 
    ProductCategory.create(name: "Cactus", site_id: SITE_ID, matrix: '3x3', color: :blue, html_color: "#336699") 
    ProductCategory.create(name: "Flowers", site_id: SITE_ID, matrix: '5x5', color: :pink, html_color: :pink)
    ProductCategory.create(name: "Ground Cover", site_id: SITE_ID, matrix: '4x4', color: :lightgreen, html_color: :lightgreen) 
    ProductCategory.create(name: "Shrubs", site_id: SITE_ID, matrix: '8x3', color: :lightblue, html_color: :lightblue)   
    
   


  end



end
