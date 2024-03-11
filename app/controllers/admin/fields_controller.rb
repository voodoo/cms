class Admin::FieldsController < MblzController
  before_filter :set_field

  def edit
    
  end

  def new
     @field = @form.fields.new
  end

  def update
    if @field.update_attributes(field_params)
      redirect_to admin_form_path(@field.form), :notice => "Field Updated"
    else
      render action: 'edit'
    end
  end

  def create
    @field = @form.fields.new(field_params)
    if @field.save
      flash[:notice] = "Field was created"
      redirect_to admin_form_path(@form)
    else
      render action: 'new'
    end
  end

  def destroy
    @field.destroy
    flash[:notice] = "Field was deleted"
    redirect_to admin_form_path(@form)    
  end

  private

  def set_field
    @form  = current_site.forms.find(params[:form_id]) if params[:form_id]
    @field = @form.fields.find(params[:id]) if @form && params[:id]
  end  

  def field_params
    params.require(:field).permit!
  end
end
