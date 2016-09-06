class Album < ActiveRecord::Base
  include PublicActivity::Common
  has_many :images, as: :imageable, dependent: :destroy
	belongs_to :photographer

  validates :name, presence: true
  accepts_nested_attributes_for :images
end
