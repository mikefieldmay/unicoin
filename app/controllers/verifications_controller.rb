class VerificationsController < ApplicationController
  skip_before_action :verify_seller!

  def edit

  end

  def update
    confirmation = Nexmo::Client.new.check_verification_request(
      request_id: params[:id],
      code: params[:code]
    )

    if confirmation['status'] == '0'
      session[:verified] = true
      redirect_to :root, flash: { success: 'Welcome back.' }
    else
      redirect_to edit_verification_path(id: params[:id]), flash: { error: confirmation['error_text'] }
    end
  end
end