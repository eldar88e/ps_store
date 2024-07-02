class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :orders, dependent: :destroy
  #has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.from_google(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    user = create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      full_name: auth.info.name,
      avatar_url: auth.info.image
    )

    UserMailer.welcome_email(user).deliver_later
    user
  end

  def self.from_email(auth)
    user = find_by(email: auth[:email])
    return user if user

    user = create(
      email: auth[:email],
      password: Devise.friendly_token[0, 20],
      full_name: auth[:full_name]
    )

    UserMailer.welcome_email(user).deliver_later
    user
  end
end
