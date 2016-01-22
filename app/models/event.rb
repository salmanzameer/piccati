class Event < ActiveRecord::Base
	
	
	has_many :images
	
	belongs_to :client	 
    belongs_to :photographer
	 
	validates :name,     presence: true 
	validates :location, presence: true
	validates :bridal ,  presence: true
	validates :groom,    presence: true
end
