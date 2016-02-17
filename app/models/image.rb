class Image < ActiveRecord::Base
	
	belongs_to :event
	
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
	:url  => "/system/events/images/000/000/00:id/:style/:basename.:extension",
	:path => ":rails_root/public/system/events/images/000/000/00:id/:style/:basename.:extension"

	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
	belongs_to :client
	def image_url
      image.url
	end
end
