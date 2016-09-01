class SessionsController< Devise::SessionsController
  before_action :restricted_action, only: [:new]

  def restricted_action
    redirect_to after_sign_in_path_for(current_photographer || current_client), notice: "You are already signed in." if (photographer_signed_in? || client_signed_in?)
  end
end