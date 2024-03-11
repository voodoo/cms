class Cms::SubmissionsController < MblzController
  def destroy
    current_site.submissions.find(params[:id]).destroy
    flash[:notice] = "Submission deleted"
    redirect_to admin_forms_path
  end
end