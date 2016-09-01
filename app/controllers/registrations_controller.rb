class RegistrationsController < Devise::RegistrationsController
	before_action :restricted_action, only: [:new]

 	protected

  def restricted_action
    redirect_to after_sign_in_path_for(current_photographer || current_client), notice: "You are already signed in." if (photographer_signed_in? || client_signed_in?)
  end

	def update_resource(resource, params)
		resource.update_without_password(params)
	end
end
