class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # @route GET /users/auth/google_oauth2 (user_google_oauth2_omniauth_authorize)
  # @route POST /users/auth/google_oauth2 (user_google_oauth2_omniauth_authorize)
  def passthru
    # render status: 404, plain: "Not Found"
    redirect_to root_path, alert: 'Аутентификация не удалась.'
  end

  def failure
    redirect_to root_path, alert: 'Аутентификация не удалась.'
  end

  # @route GET /users/auth/google_oauth2/callback (user_google_oauth2_omniauth_callback)
  # @route POST /users/auth/google_oauth2/callback (user_google_oauth2_omniauth_callback)
  def google_oauth2
    user = User.from_google(request.env['omniauth.auth'])

    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end
end
