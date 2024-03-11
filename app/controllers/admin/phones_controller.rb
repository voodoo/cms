class Admin::PhonesController < MblzController
  before_filter :set_phone, :only => [:edit, :update]
  def new
    @phone = current_site.twilio_config.phones.new
  end

  def edit
  end
  
  def update
    @phone.update_attributes(phone_params)
    flash[:notice] = "Phone Updated"
    redirect_to edit_admin_twilio_config_path(current_site.twilio_config)    
  end

  def create
    current_site.twilio_config.phones.create(phone_params)
    flash[:notice] = "Phone Created"
    redirect_to edit_admin_twilio_config_path(current_site.twilio_config)
  end

  private

  def set_phone
    @phone = current_site.twilio_config.phones.find(params[:id])
  end

  def phone_params
    params.require(:phone).permit!
  end

end
