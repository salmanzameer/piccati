class Event < ActiveRecord::Base
  include PublicActivity::Common
	belongs_to :client	 
  belongs_to :photographer
	has_many :images, as: :imageable	 
	
 	validates :name,        	presence: true 
	validates :location,    	presence: true
	validates :bridal ,     	presence: true
	validates :groom,       	presence: true
  validates :start_time,  	presence: true
  validates :client_id,   	presence: true
  validates :category_id,   presence: true

	
  def selected
    self.images.where(is_liked: true)
  end
end
