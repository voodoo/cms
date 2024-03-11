class Admin::TwilioConfigsController < MblzController

  skip_before_filter :has_permission?, :only => [:edit, :update]
  before_filter :set_site_twilio, :except => [:index, :active_numbers, :release_number]
  #,      :only => [:edit, :update]


  def index
    @numbers = Twilio::IncomingPhoneNumber.all
    @configs = TwilioConfig.with_incoming_phone
  end

  def active_numbers
    @numbers = Twilio::IncomingPhoneNumber.all
  end

  def edit

  end

  def update
    if @twilio.update_attributes(twilio_params)
      flash[:notice] = "Update Complete"
    else
      flash[:alert]  = "Update Failed"
    end
    if current_user.admin?
      redirect_to admin_site_path(@twilio.site)
    else
      redirect_to mblz_root_path
    end
  end

  def numbers
    @numbers = TwilioConfig.available_numbers
  end



  def set_number
    number = Twilio::IncomingPhoneNumber.create(:phone_number => params[:n], :voice_url => "https://#{@twilio.site.subdomain}.mblz.com/twilios")
    @twilio.update_attributes(:sid => number.sid, :incoming_phone => params[:n])
    redirect_to admin_site_path(@twilio.site)
  end

  def release_number
   phone = Twilio::IncomingPhoneNumber.find params[:sid]

   logger.warn phone.sid
   phone.destroy if Rails.env.production?

   redirect_to admin_twilio_configs_path
  end

  protected

  def twilio_params
    params.require(:twilio_config).permit!
  end
  def set_site_twilio
    if current_user.admin?
      @twilio = TwilioConfig.find(params[:id])
    else
      @twilio = current_site.twilio_config
    end
  end
end
