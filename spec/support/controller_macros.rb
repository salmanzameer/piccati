module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:photographer]
      photographer = Factory.create(:photographer)
      # or set a confirmed_at inside the factory. Only necessary if you
      # are using the confirmable module
      photographer.confirm!
      sign_in photographer
    end
  end
end