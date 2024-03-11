class Twilios::CallsController < Twilios::BaseController

  before_filter :recognize_user_phone, only: :create

  def create
  end

  def recording_complete
    @call.update_attributes(recorded_message_url: params[:RecordingUrl], :recorded_message_duration => params[:Duration])
    render :nothing => true
  end

  def transcription_complete
    transcript = params[:TranscriptionText]
    if transcript.present? && transcript.size > 1020
      Mailer.ping('Transcript truncated', transcript, request).deliver_now
      transcript = transcript.truncate(1020)
    end
    @call.update_attributes(:recorded_message_transcript => transcript)
    render :nothing => true
  end

  def answered
    @call.update_attributes(answered_by: params[:answered_by])
  end

  private

  def recognize_user_phone
    # phone recognized
    if @call.user && @call.user.pin.present?
      render action:  'recognized_user_phone'
      return false
    end    
  end



end