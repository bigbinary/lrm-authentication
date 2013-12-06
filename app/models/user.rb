class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    save!
  end

  def self.reset_authentication_token_for_authorised_user user_email, authToken
    user = user_email && User.find_by_email(user_email)
    if user && Devise.secure_compare(user.authentication_token, authToken)
      user.reset_authentication_token!
      true
    else
      false
    end
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token:token).exists?
      end
    end

end
