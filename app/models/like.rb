class Like < ActiveRecord::Base
  belongs_to :image, counter_cache: true
  belongs_to :client
end