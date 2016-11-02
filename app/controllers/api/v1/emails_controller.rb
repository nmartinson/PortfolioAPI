class Api::V1::EmailsController < Api::V1::ApplicationController

  def show
    render plain: "NOTHING"
  end

  def create
    if params[:email].present? && params[:body].present?
      Contact.send_contact_email(params).deliver_now!
    end
    render plain: "email"
  end

end