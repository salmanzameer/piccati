class PhotographerClient < ActiveRecord::Base

	belongs_to :photographer
	belongs_to :client

  validates :package, presence: true
  validates :total, presence: true
  validates :balance, presence: true
  validates :advance, presence: true
end
