class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, uid:, provider: )
    return unless email =~ /@mybusiness.com\z/
    create_with(uid: uid).find_or_create_by!(email: email, provider: provider)
  end
end
