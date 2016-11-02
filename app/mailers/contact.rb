class Contact < ActionMailer::Base
  default :from => 'photoinquiries@boundless-journey.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_contact_email(params)
    mail( :to => params[:email],
    :subject => params[:subject], :body => params[:body])
  end
end
