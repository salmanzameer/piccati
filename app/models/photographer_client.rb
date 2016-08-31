class PhotographerClient < ActiveRecord::Base

	belongs_to :photographer
	belongs_to :client

  validates :package_id, presence: true, on: :update
  validates :total, 	presence: true, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validates :advance, presence: true, numericality: { greater_than_or_equal_to: 0 }, on: :update

  scope :is_connected?, -> { where(is_connected: true) }

  def calc_balance(params)
    total = params[:total].gsub(',','').to_i
    advance = params[:advance].gsub(',','').to_i
    balance = total - advance
    self.update(total: total, advance: advance, balance: balance, package_id: params[:package_id])
    self
  end
end