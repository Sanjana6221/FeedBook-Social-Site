class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

 	def configure_permitted_parameters
 		
 		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
 		  user_params.permit(:email, :password, :password_confirmation, :firstname, :lastname, :country, :birth_date, :language)

 		end
	end
end
