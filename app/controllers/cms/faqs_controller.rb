class Cms::FaqsController < MblzController
  # GET /faqs
  # GET /faqs.xml
  def index
    @faqs = @current_site.faqs.find(:all)
    # push into site layout
    @page_params = {
      #'params'      => request.params,
      #'controller'  => controller_name,
      #'host'        => request.host,
      'path'        => request.path
    }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @faqs }
    end
  end

  # GET /faqs/1
  # GET /faqs/1.xml
  def show
    @faq = @current_site.faqs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/new
  # GET /faqs/new.xml
  def new
    @faq = @current_site.faqs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/1/edit
  def edit
    @faq = @current_site.faqs.find(params[:id])
  end

  # POST /faqs
  # POST /faqs.xml
  def create
    @faq = @current_site.faqs.new(params[:faq])

    respond_to do |format|
      if @faq.save
        flash[:notice] = 'Faq was successfully created.'
        format.html { redirect_to(cms_faqs_path) }
        format.xml  { render :xml => @faq, :status => :created, :location => @faq }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /faqs/1
  # PUT /faqs/1.xml
  def update
    @faq = @current_site.faqs.find(params[:id])

    respond_to do |format|
      if @faq.update_attributes(params[:faq])
        flash[:notice] = 'Faq was successfully updated.'
        format.html { redirect_to(cms_faqs_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.xml
  def destroy
    @faq = @current_site.faqs.find(params[:id])
    @faq.destroy

    respond_to do |format|
      format.html { redirect_to(cms_faqs_path) }
      format.xml  { head :ok }
    end
  end
  def sort
    params[:faqs].each_with_index do |id, index|
      @current_site.faqs.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  
  def version
    @faq = @current_site.faqs.find(params[:id])
    @faq.revert_to!(params[:version].to_i)
    redirect_to edit_cms_faq_path(@faq)
    flash[:notice] = 'Reverted to version ' + params[:version]
  end  

end
