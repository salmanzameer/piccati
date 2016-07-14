class Image < ActiveRecord::Base
  after_create :after_upload
  belongs_to :client
	belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
  processors: [:watermark],
  styles: lambda { |attachment| { 
      original: { geometry: "500x500", watermark_path: attachment.instance.watermark_url, position: "Center" },
      medium: "300x300>"
    }
  },
  :url  => "/system/events/images/000/000/00:id/:style/:basename.:extension",
	:path => ":rails_root/public/system/events/images/000/000/00:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => {
    :bucket => 'gls-testing', 
    :access_key_id => 'AKIAJ2CZ275DJXIPIAEQ',
    :secret_access_key => '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' 
  }
  validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 15.megabytes
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  def watermark_url
    Photographer.current_photographer.watermark_logo.url if Photographer.current_photographer.present? && Photographer.current_photographer.watermark_logo.present?
  end

	def image_url
    image.url
	end

  def after_upload
    if self.imageable_type == "Event"
      photographer = self.imageable.client.photographer
    elsif self.imageable_type == "Album"
      photographer = self.imageable.photographer
    end  
    old_memory = photographer.memory_consumed
    new_memory = self.image_file_size + old_memory
    photographer.update_attributes(memory_consumed: new_memory)
  end

end
