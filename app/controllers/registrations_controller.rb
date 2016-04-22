class RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!

  def update

		self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
		prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
		resource_updated = update_resource(resource,update_params)
		yield resource if block_given?
		if resource_updated
			if is_flashing_format?
				flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
				:update_needs_confirmation : :updated
				set_flash_message :notice, flash_key
			end
			sign_in resource_name, resource, bypass: true
			respond_with resource, location: profile_path(current_user.id)
		else
			clean_up_passwords resource
			respond_with resource
		end
	end

  def update
		self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
		prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
		resource_updated = update_resource(resource,update_params)
		yield resource if block_given?
		if resource_updated
			if is_flashing_format?
				flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
				:update_needs_confirmation : :updated
				set_flash_message :notice, flash_key
			end
			sign_in resource_name, resource, bypass: true
			respond_with resource, location: profile_path(current_user.id)
		else
			clean_up_passwords resource
			respond_with resource
		end
	end

	protected

	  def update_params
  		params.require(:user).permit(:first_name, :last_name, :gender, :email, :avatar, :username)
  	end

  	def update_resource(resource,params)
    	resource.update_without_password(params)
    end

    # def pass_params
    #   # NOTE: Using `strong_parameters` gem
    #   params.required(:user).permit(:password, :password_confirmation, :changed_password)
    # end

    def after_sign_up_path_for(resource)
      edit_user_registration_path
    end
end
