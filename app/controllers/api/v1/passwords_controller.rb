class Api::V1::PasswordsController < Devise::PasswordsController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def create
    if User.exists?(email: params[:email])
      render json: {success: true}
    else
      render json: {success: false}, status: :not_found
    end
  end

end
