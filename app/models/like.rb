class Like < ActiveRecord::Base
	include PublicActivity::Common
  belongs_to :image, counter_cache: true
  belongs_to :client

  def self.is_liked?(client)
  	where(client_id: client.id, like: true).present?
  end
end