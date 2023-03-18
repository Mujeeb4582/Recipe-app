class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :public_page?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def public_page?
    controller_name == 'public_recipes' && action_name == 'index'
  end
end
