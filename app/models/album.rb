class Album < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]


  include PublicActivity::Common
  
  before_destroy :memory_refactor
  has_many :images, as: :imageable, dependent: :destroy
	belongs_to :photographer

  validates :name, presence: true
  accepts_nested_attributes_for :images

  def memory_refactor
    images.each do |image|
      photographer.memory_refactor(image.image_file_size)
    end
  end
end
