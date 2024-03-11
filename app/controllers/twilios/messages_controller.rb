class Twilios::MessagesController < ApplicationController
  layout nil
  skip_before_filter :verify_authenticity_token
 
  # Incoming text message to site
  def create
    # Send a TM to ET
    Twilio::SMS.create to:    APP_CONFIG[:phone], 
                       from:  current_site.twilio_config.incoming_phone,
                       body:  params[:Body][0...159]

    # Add it to comments so it shows up in activities
    comment = current_site.comments.create(to_phone: params[:To], from_phone: params[:From], comment: params[:Body])
    comment.attach_medias(params)
  end

  # private
  # def get_cookies
  # 	[session[:commentable_id], session[:commentable_type], session[:comment_id]].join(',')
  # end
end