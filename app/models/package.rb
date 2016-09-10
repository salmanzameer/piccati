class Package < ActiveRecord::Base
  belongs_to :photographer
  
  validates :name, presence: true
  validates :picture_dslr_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :video_dslr_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :album_leaves, presence: true, numericality: { greater_than_or_equal_to: 0 }
end