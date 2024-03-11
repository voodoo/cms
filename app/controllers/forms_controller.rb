class FormsController < ApplicationController
  #include SimpleCaptcha::ControllerHelpers
  before_filter :set_cors, :only => [:create]

  
  skip_before_filter :verify_authenticity_token, :only => :xhr_post

  before_filter :set_form, except: :update
  
  layout false
  
  def index
    show
  end

  def show
    render json: @form.fields.to_json
  end

  def create
    # Get rid of rails params
    [:controller, :action].each do |pm|
      params.delete(pm)
    end

    submission = @form.submissions.create(
      :response           => params.to_hash, 
      :site_id            => current_site.id, 
      :ip                 => request.remote_ip, 
      :title              => @form.title)
    
    url = "https://#{current_site.subdomain}.mblz.com/mblz/submissions/#{submission.id}"

    Activity.create!(
        action:         "created", 
        trackable_id:   submission.id,
        trackable_type: 'Submission', 
        site_id:        current_site.id, 
        contact_id:     nil, 
        note:           "Form was created from remote '#{request.referer}'"
    )

    unless Rails.env.development?
      if !current_site.twilio_config.incoming_phone.blank?
        Twilio::SMS.create to:    APP_CONFIG[:phone], 
                           from:  current_site.twilio_config.incoming_phone,
                           body:  "New Contact Form: #{url}"
      end
    end 

    render text: 'Thank you'
  end


  def update
    JavascriptMailer.client_error(params).deliver_now
    render nothing: true
  end
  

  protected
  
  def set_form
    #sleep(2)
    @form = current_site.forms.find(params[:id] || current_site.forms.first.id)    
  end
  
  def set_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end  
end