class Like < ActiveRecord::Base
	include PublicActivity::Common
  belongs_to :image, counter_cache: true
  belongs_to :client
end