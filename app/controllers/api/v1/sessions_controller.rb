class Api::V1::SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def create
    user_params = user_login_params
    user = User.find_for_database_authentication(email: user_params[:email])

    if params[:give_me_500]
      raise 'raising error so that client gets 500 internal server error'
    elsif user.blank? || !user.valid_password?(user_params[:password])
      unauthorized_response
    else
      user.reset_authentication_token! unless user.authentication_token
      render json: {success: true, authToken: user.authentication_token}
    end
  end

  def destroy
    unless User.reset_authentication_token_for_authorised_user params[:email], params[:authToken]
      unauthorized_response and return
    end
    render json: {success: true}
  end

  private

  def unauthorized_response
    warden.custom_failure!
    render json: {success: false }, status: :unauthorized
  end

  def user_login_params
    params.require(:user).permit(:password, :email)
  end

end
