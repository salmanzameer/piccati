class Album < ActiveRecord::Base
	has_many :images, as: :imageable
	belongs_to :photographer
end
