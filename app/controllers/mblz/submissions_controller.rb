class Mblz::SubmissionsController < MblzController
  
  def index
    @forms = current_site.submissions.order('created_at desc').page(params[:page])
  end
  
  def show
    @form = current_site.submissions.find(params[:id]) 
    @ip_count = current_site.submissions.where("ip = ?", @form.ip).count 
  end

  def destroy
    current_site.submissions.find(params[:id]).destroy
    redirect_to mblz_submissions_path, :notice => "Form deleted" 
  end

end