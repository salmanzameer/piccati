class PhotographerClient < ActiveRecord::Base

	belongs_to :photographer
	belongs_to :client
end
