require "rails_helper"
describe Api::V1::ClientsController do

	let!(:photographer) { FactoryGirl.create(:photographer, email: 'asdas@gmail.com', username: 'ali')}
	let!(:client)  { FactoryGirl.create(:client ,photographer_id: photographer.id ) }
	let!(:client1) { FactoryGirl.create(:client ,photographer_id: photographer.id, email: "zain@gmail.com", password: "1234567890K" ) }
	let!(:client2) { FactoryGirl.create(:client  ,photographer_id: photographer.id, email: "zeeshan@gmail.com", password: "qazwsxedc")}
	let!(:client3) { FactoryGirl.create(:client ,photographer_id: photographer.id, email: "zainali@gmail.com", password: "haider123" ) } 
    let!(:client4) { FactoryGirl.create(:client ,photographer_id: photographer.id, email: "waqas@gmail.com", password: "qwertyuiop")}	 
		context "GET/ #index" do
		it "Show all the clients" do
			sign_in(photographer)
			
         get "/api/v1/photographers/#{photographer.id}/clients.json" 

	end 
end
end