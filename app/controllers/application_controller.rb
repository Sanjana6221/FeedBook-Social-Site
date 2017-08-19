class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameter, if: :devise_controller?
  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  protected

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit(:email, :password, :password_confirmation, :firstname, 
      :lastname, :country, :birth_date, :language)
  end

  devise_parameter_sanitizer.permit(:account_update) do |u|
    u.permit(:name,
    :email, :password, :password_confirmation, :current_password, 
    :firstname,:lastname,:country,:language,:birth_date)
    end
  end
end
