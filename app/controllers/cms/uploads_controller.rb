class Cms::UploadsController < MblzController
  before_filter :set_upload
  def index
    @folders = current_site.folders.order('position')
    #@folder =  current_site.folders.new
  end
  
  def show
    
  end

  def new
    @upload = current_site.uploads.new(folder_id: params[:f])
  end

  def move
    @upload.move!(params[:d])
     flash[:notice] = "Upload moved"
    redirect_to cms_uploads_path
  end

  def update
    @upload.update_attributes(upload_params)
    flash[:notice] = "Upload updated"
    redirect_to cms_uploads_path
  end

  def create
    upload = current_site.uploads.new(upload_params)
    if upload.save
      flash[:notice] = "Upload Added"
      
    else
      flash[:warn] = "Invalid Upload"      
    end
    redirect_to cms_uploads_path
  end  
  

  def destroy
    current_site.uploads.find(params[:id]).destroy
    flash[:notice] = "Upload deleted"
    redirect_to :action => :index
    #flash[:notice] = "Upload deleted"
    #redirect_to cms_uploads_path    
  end

  private

  def upload_params
    params.require(:upload).permit!
  end

  def set_upload
    if params[:id]
      @upload = current_site.uploads.find(params[:id])  
    end
  end
end
