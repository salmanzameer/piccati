class Enquiry < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :photographer
	belongs_to :client
end
