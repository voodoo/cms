class AddSubmissionToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :submission_id, :integer
  	reorder_form_field
  end

  def reorder_form_field
  	for form in Form.all
  		form.fields.each_with_index do |field, index|
      	new_position = index + 1
      	field.update_attributes(:position => new_position)
  		end
  	end
  end
end
