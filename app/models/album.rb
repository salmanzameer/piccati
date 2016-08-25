class Album < ActiveRecord::Base
  include PublicActivity::Common
  
	has_many :images, as: :imageable
	belongs_to :photographer

  validates :name, presence: true
end
