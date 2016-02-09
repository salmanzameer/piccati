module RequestMacros
  def login(photographer)
    page.driver.post photographer_session_path, 
      :photographer => {:email => photographer.email, :password => photographer.password}
  end
end