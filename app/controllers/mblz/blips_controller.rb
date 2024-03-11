class Mblz::BlipsController < MblzController
  before_filter :set_title
  
  def index
    @blips = current_site.blips
  end
  def create
    current_site.blips.create(blip_params.merge(user_id: current_user.id))
    redirect_to :action => 'index'
  end

  def new
    @sub  = current_site.submissions.find(params[:sid])
    @blip = current_site.blips.new(:ip => @sub.ip, :submission_id => @sub.id)
  end

  def destroy
    blip  = current_site.blips.find(params[:id])
    forms = current_site.submissions.where('ip = ?', blip.ip)
    if forms.size > 0
      forms.each(&:destroy)
      notice = "Forms destroyed"
    else
      blip.destroy
      notice = "Black list removed"
    end
    flash[:notice] = notice
    redirect_to :action => 'index'
  end

private
  def blip_params
    params.require(:blip).permit!
  end
  def set_title
    @title = 'Black Listed IPs'
  end

end