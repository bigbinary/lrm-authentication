class Api::V1::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user_from_token!
  respond_to :json

  rescue_from Exception, with: :handle_exception_in_api_request

  private

  def handle_exception_in_api_request
    render json: {success: false}, status: :internal_server_error
  end

  # Replacement for token_authenticable
  def authenticate_user_from_token!
    user_email = params[:email].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:authToken])
      sign_in user, store: false
    end
  end
end
