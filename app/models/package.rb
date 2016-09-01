class Package < ActiveRecord::Base
  belongs_to :photographer
  
  validates :name, presence: true
  validates :picture_dslr_count, presence: true
  validates :video_dslr_count, presence: true
  validates :album_leaves, presence: true
end