
 require "rails_helper"

describe Api::V1::PhotographersController do
   
    let!(:client) { FactoryGirl.create(:client ) }
    let!(:event) { FactoryGirl.create(:event)}
    let!(:photographer) { FactoryGirl.create(:photographer, client_id: client.id, event_id: event.id, email: "java@gmail.com", username: "java") }
    before do
         sign_in
    end
    context "GET /photographers" do
       it "Gives is the expected status code when authenticated." do
       
            get  "/api/v1/photographers/#{photographer.id}"

          
            json = JSON.parse(response.body)
           
            photographer.title      == json['photographer']['title']
            photographer.firstname  == json['photographer']['firstname']
            photographer.lastname   == json['photographer']['lastname']
            photographer.contnumber == json['photographer']['contnumber']
            photographer.username   == json['photographer']['username']
            photographer.email      == json['photographer']['email']
          
        end    
    end
end
  #   describe Api::V1::PhotographersController do
  #       describe "GET/sign_in" do
  #   let(:photographer) { FactoryGirl.create(:photographer) }

  #   it "should allow a registered user to sign in" do
  #      new_photographer_session_path
  #     fill_in "Email", :with => photographer.email
  #     fill_in "Password", :with => photographer.password
  #     click_button "Sign in"
  #     page.should have_content("Welcome")
  #   end

  #   it "should not allow an unregistered user to sign in" do
  #      new_photographer_session_path
  #     fill_in "Email", :with => "notarealuser@example.com"
  #     fill_in "Password", :with => "fakepassword"
  #     click_button "Sign in"
  #     page.should_not have_content("Welcome")
  #   end
  # end
  # end