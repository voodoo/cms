module FormsHelper
  REQUIRED_DELIMETER = ' * '


  def titled_field_for(field)
    label = content_tag :label do
        if field.required?
          concat required_field_delimeter
        end
        concat field.title
      end
    field = if field.field_type == 'Text'
        text_field_tag field.name, field.options, :title => field.title, data: {mblz: true, required: field.required?}
       elsif field.field_type == 'Textarea'
        text_area_tag field.name, nil,  :title => field.title, data: {mblz: true, required: field.required?}
       else
        select_tag field.name, options_for_select(field.options.split(',')), :title => field.title, data: {mblz: true, required: field.required?}
       end

    [label,field]
  end

  def required_field_delimeter
    ('<span class="required_field_delimeter">' + REQUIRED_DELIMETER + '</span>').html_safe
  end
end


