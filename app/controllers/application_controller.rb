class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address, :categories, :radius])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :categories, :radius])
  end
end
