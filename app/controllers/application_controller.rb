class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	teachings_path
  end

  def after_sign_up_path_for(resource)
    teachings_path
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

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :gender << :first_name << :last_name
  end

end
