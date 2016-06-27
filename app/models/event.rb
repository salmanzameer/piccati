class Event < ActiveRecord::Base
	belongs_to :client	 
  belongs_to :photographer
	has_many :images, as: :imageable	 
	
	validates :name,     presence: true 
	validates :location, presence: true
	validates :bridal ,  presence: true
	validates :groom,    presence: true
end
