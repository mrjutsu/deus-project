class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  	teachings_path
  end

  def after_sign_up_path_for(resource)
    teachings_path
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    session["user_return_to"] || edit_user_registration_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :email
    devise_parameter_sanitizer.for(:account_update) << :gender << :first_name << :last_name
    devise_parameter_sanitizer.for( :sign_in ) << :login
  end

end
