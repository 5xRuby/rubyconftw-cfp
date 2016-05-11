class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :github].each do |provider|
    provides_callback_for provider
  end

  
  
  
  
  def failure
    redirect_to new_user_session_path
  end
end