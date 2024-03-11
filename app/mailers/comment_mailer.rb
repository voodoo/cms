class CommentMailer < ActionMailer::Base

  def comment(comment, to)
  	@body = comment.comment
  	mail(to: to, subject: comment.title, from: comment.site.twilio_config.incoming_phone)
  end

end
