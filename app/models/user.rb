class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :orders, dependent: :destroy
  #has_many :carts, dependent: :destroy

  def self.from_google(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    user = create(provider: auth.provider, uid: auth.uid) do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0, 20]
      user.full_name  = auth.info.name
      user.avatar_url = auth.info.image
    end

    UserMailer.welcome_email(user).deliver_now
    user
  end
end
