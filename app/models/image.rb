class Image < ActiveRecord::Base

	belongs_to :event
	belongs_to :client

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
	:url  => "/system/events/images/000/000/00:id/:style/:basename.:extension",
	:path => ":rails_root/public/system/events/images/000/000/00:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => {
    :bucket => 'gls-testing', 
    :access_key_id => 'AKIAJ2CZ275DJXIPIAEQ',
    :secret_access_key => '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' 
  }  
	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

	def image_url
      image.url
	end
end
