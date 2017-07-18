class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :configure_account_update_params, only: [:update]

  protected

 	def configure_permitted_parameters
 		
 		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
 		  user_params.permit(:email, :password, :password_confirmation, :firstname, :lastname, :country, :birth_date, :language)

 		end
	end

	 def configure_account_update_params

    devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:name,
          :email, :password, :password_confirmation, :current_password,:firstname,:lastname,:country,:language,:birth_date)
    end
  end
end
