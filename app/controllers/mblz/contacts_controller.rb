class Mblz::ContactsController < MblzController
  before_filter :set_contact, :except => [:index]

  def map
    render layout: 'map'
  end

  def call
    @contact = current_site.contacts.find(params[:id])
    @token   = Twilio::CapabilityToken.create(:allow_outgoing => current_site.twilio_config.capability_outgoing)
  end

  def touch
    track_activity @contact, "Moved to top of Now page"
    @contact.touch
    flash[:notice] = "Contact Updated"  
    redirect_to action: :show
  end

  def index
    @contacts = current_site.contacts.order('updated_at desc').page(params[:page])
  end

  def release_priority
    @contact.release_priority!
    track_activity @contact
    flash[:notice] = "Priority released"
    redirect_to mblz_contact_path(@contact)
  end


  def destroy
    if @contact.invoices.empty?
      full_name = @contact.full_name
      @contact.destroy
      track_activity @contact, "#{full_name} was destroyed"
      redirect_to mblz_contacts_path, notice: 'Contact destroyed'
    else
      redirect_to mblz_contact_path(@contact), notice: 'Can not delete a contact with invoices, please delete them first.'
    end

  end

  def new
    @contact = current_site.contacts.new
    @contact.state = 'Texas'
  end
  
  def create
    @contact = current_site.contacts.new(contact_params)
    if @contact.save
      track_activity @contact
      redirect_to mblz_contact_path(@contact), :notice => "Created Contact"
    else
      render :new
    end
  end

  def update
    if @contact.update_attributes(contact_params)
      flash[:notice] = "Contact Updated"
      track_activity @contact
      redirect_to mblz_contact_path(@contact)
    else
      render :action => 'edit'
    end
  end


  def update_priority
    @contact.update_attribute(:priority, params[:contact][:priority])
    track_activity @contact, "Updated Priority"
    render text: "Priority updated to #{@contact.priority_name}"
  end

  def export
    owner_email = current_site.email
    Mailer.export_contact(owner_email,@contact).deliver
    track_activity @contact
    redirect_to request.referer, :notice => 'Sent'
  end

  def export_all
    if current_user.owner_or_above?
      export = Contact.export_all(current_site)
      send_data export, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=export_contact_invoices_#{current_site.subdomain}.csv"     
    else
      raise "Tried to access contacts"
    end   
  end

  def lookup
    contacts = current_site.contacts.search_for(params[:q])
    results  = contacts.map{|c| {id: c.id, text: c.full_name}}
    render :json => results
  end

  def uniq
    last_name, email, phone = params[:contact_last_name], params[:contact_email], params[:contact_phone]
    if last_name
     last_name = "%#{last_name}%"
     @contacts = current_site.contacts.where("last_name like ?", last_name).limit('3').order('created_at desc')
    elsif email
     @contacts = current_site.contacts.where(email: email).limit('3').order('created_at desc')
    elsif phone
     @contacts = current_site.contacts.where(phone: phone.gsub(/\D/,'')).limit('3').order('created_at desc')
    end
    if @contacts.empty?
      render :nothing => true
      return
    end
    render :layout => false
  end

  # def update_contactables
  #   @contact = current_site.contacts.find(params[:contact_id])
  #   @contact.update_contactables(params[:id])
  # end

  # try to make a contact from a web contact form
  def create_from_form
    submission = current_site.submissions.find(params[:form])
    @contact    = current_site.contacts.new(:submission_id => submission.id)
    submission.response.each do |k,v|
      if @contact.has_attribute?(k.underscore.to_sym)
        @contact[k.underscore.to_sym] = v
      end
    end
    if @contact.save
      flash[:notice] = "Contact was created from form"
      redirect_to mblz_contact_path(@contact)
    else
      render action: 'new'
    end
  end

  private
  def contact_params
     params.require(:contact).permit!
  end  
  def set_contact
    @contact = current_site.contacts.find(params[:id]) if params[:id]
  end
end