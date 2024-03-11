class Cms::FoldersController < MblzController

  def index
    
  end
  
  def update
    folder = Folder.find(params[:id])
    folder.update_attributes(folder_params)
    flash[:notice] = "Folder updated"
    redirect_to cms_uploads_path  
  end

  def create
    folder = current_site.folders.create(folder_params)
    flash[:notice] = folder.valid? ? "Folder Added" : "Failed: #{folder.errors.full_messages}"
    redirect_to cms_uploads_path
  end
  
  def destroy
    current_site.folders.find(params[:id]).destroy
    # render :update do |page|
    #   page << "$('#folder#{params[:id]}').slideUp('slow')"
    # end
  end
  def move
    current_site.folders.find(params[:id]).move!(params[:d])
    flash[:notice] = "Folder moved"
    redirect_to cms_uploads_path
  end
  private

  def folder_params
    params.require(:folder).permit!
  end
end
