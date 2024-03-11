class Cms::StylesController < MblzController

  # GET /styles
  # GET /styles.xml
  before_filter :set_styles#, :except => [:update, :destroy, :create]
  #before_filter :clear_cache, :only => [:update, :delete, :create]

  def index
    @style  = @styles.first
    @style.revert_to(params[:version].to_i) if params[:version]
    render :action => :edit

  end

  def new
    @style = @current_site.styles.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @style }
    end
  end

  # GET /styles/1/edit
  def edit
    @style = @current_site.styles.find(params[:id])
    #@style.revert_to(params[:version].to_i) if params[:version]
  end

  # POST /styles
  # POST /styles.xml
  def create
    @style = @current_site.styles.new(params[:style])

    respond_to do |format|
      if @style.save
        flash[:notice] = 'Style was successfully created.'
        format.html { redirect_to(edit_cms_style_path(@style)) }
        format.xml  { render :xml => @style, :status => :created, :location => @style }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /styles/1
  # PUT /styles/1.xml
  def update
    @style.update_attributes(params[:style])
    redirect_to :action => :index, :notice => "Update Complete"
    #render :layout => false
  end

  # DELETE /styles/1
  # DELETE /styles/1.xml
  def destroy
    @style = @current_site.styles.find(params[:id])
    @style.destroy
    flash[:notice] = "Style was deleted"
    respond_to do |format|
      format.html { redirect_to(cms_styles_path) }
      format.xml  { head :ok }
    end
  end

  def sort
    params[:styles].each_with_index do |id, index|
      @current_site.styles.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  def version
    @style = current_site.styles.find(params[:id])
    @style.revert_to!(params[:version].to_i)
    redirect_to edit_cms_style_path(@style)
    flash[:notice] = 'Reverted to version ' + params[:version]
  end    
  

  protected
  def set_styles
    @style  = current_site.styles.find(params[:id]) if params[:id]
    @styles = @current_site.styles    
  end
  def clear_cache
    expire_page('/css')
  end
end
