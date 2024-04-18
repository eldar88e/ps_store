class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0, 20]
      user.full_name  = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end
