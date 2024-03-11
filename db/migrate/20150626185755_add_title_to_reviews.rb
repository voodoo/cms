class AddTitleToReviews < ActiveRecord::Migration
  def change
  	add_column 		:reviews, :title, :string
  	add_column 		:reviews, :original_comment, :text
  	add_column 		:reviews, :icon, :string, default: 'heart'
  end
end
