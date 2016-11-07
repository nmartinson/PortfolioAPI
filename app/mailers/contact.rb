class Contact < ActionMailer::Base
  default :from => 'photoinquiries@boundless-journey.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_contact_email(params)
    @contact = params;
    mail( :to => 'nickmartinson986@gmail.com',
    :subject => params[:subject])
  end
end
