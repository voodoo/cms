class Admin::FormsController < MblzController
  before_filter :set_form
  
  def index
    @forms = current_site.forms.page(params[:page])
  end

  def update
      @form = @current_site.forms.find(params[:id])
      @form.update_attributes(form_params)
      render :action => :show, :notice => "Form Updated"
  end

  def new
    form = current_site.create_default_form!
    flash[:notice] = "Form was created with default fields. Bend to fit"
    redirect_to admin_form_path(form)
  end
  
  def create
    @form = @current_site.forms.create(form_params)
    redirect_to edit_admin_form_path(@form)
  end
  
  def destroy
    @form = @current_site.forms.find(params[:id])
    @form.destroy
    flash[:notice] = "Form deleted"
    redirect_to admin_forms_path
  end
  
  def sort
    params[:forms].each_with_index do |id, index|
      current_site.forms.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  
  protected

  def set_form
    @form = current_site.forms.find(params[:id])  if params[:id]  
  end

  def form_params
    params.require(:form).permit!
  end
end