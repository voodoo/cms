class Cms::LayoutsController < MblzController
  # GET /layouts
  # GET /layouts.xml
  before_filter :set_layouts, :except => [:update, :destroy, :create]

  def index
    @layout  = @layouts.first
    @layout.revert_to(params[:version].to_i) if params[:version]
    render :action => :edit
  end

  # GET /layouts/1
  # GET /layouts/1.xml
  # def show
  #   @layout = @current_site.layouts.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @layout }
  #   end
  # end

  # GET /layouts/new
  # GET /layouts/new.xml
  def new
    @layout = @current_site.layouts.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @layout }
    end
  end

  # GET /layouts/1/edit
  def edit
    @layout = @current_site.layouts.find(params[:id])
  end

  # POST /layouts
  # POST /layouts.xml
  def create
    @layout = @current_site.layouts.new(layout_params)

    respond_to do |format|
      if @layout.save
        flash[:notice] = 'Layout was successfully created.'
        format.html { redirect_to(edit_cms_layout_path(@layout)) }
        format.xml  { render :xml => @layout, :status => :created, :location => @layout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @layout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /layouts/1
  # PUT /layouts/1.xml
  def update
    @layout = current_site.layouts.find(params[:id])
    @layout.update_attributes(layout_params)
    flash.now[:notice] = "Update Complete"
    render :action => 'edit'
  end

  # DELETE /layouts/1
  # DELETE /layouts/1.xml
  def destroy
    @layout = @current_site.layouts.find(params[:id])
    @layout.destroy
    flash[:notice] = "Layout was deleted"
    respond_to do |format|
      format.html { redirect_to(cms_layouts_path) }
      format.xml  { head :ok }
    end
  end

  def sort
    params[:layouts].each_with_index do |id, index|
      @current_site.layouts.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  protected
  def set_layouts
    @layouts = @current_site.layouts
    
  end

  private

  def layout_params
    params.require(:layout).permit!
  end

end
