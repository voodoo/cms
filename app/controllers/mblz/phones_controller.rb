class Mblz::PhonesController < MblzController
  before_filter :set_user

  def edit
  end

  def update
    if @phone.update_attributes(params[:phone])
      redirect_to mblz_root_path, :notice => "Phone updated"
    else
      flash.now[:alert] = "Update failed"
      render :action => 'edit'
    end
  end


  private
  def set_user
    @phone = current_site.twilio_config
  end
end
