class Admin::WheresController < MblzController
  layout 'cards'
  def create
  	email = params[:email]
  	count = params[:count]
  	HereIAmMailer.where_are_you(email,count).deliver_now
  	render text: count
  end
end