
require "rails_helper"
#require "devise_support"
# Request specs for the invoices controller.
describe Api::V1::PhotographersController do
let!(:photographer) { FactoryGirl.create(:photographer) }
    before do
         allow_any_instance_of(Api::ApplicationController).to receive(:current_photographer).and_return(photographer)
    end
    context "GET /photographers" do
       it "Gives is the expected status code when authenticated." do
            get  "/api/v1/photographers/#{photographer.id}"

            # Ensure we get the expected response code.
            response.status.should be(200)
        end    
    end
end