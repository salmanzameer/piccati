class PhotographerClient < ActiveRecord::Base

	belongs_to :photographer
	belongs_to :client

  validates :package, presence: true, on: :update
  validates :total, 	presence: true, on: :update
  validates :balance, presence: true, on: :update
  validates :advance, presence: true, on: :update

  scope :is_connected?, -> { where(is_connected: true) }
end