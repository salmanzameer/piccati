class Image < ActiveRecord::Base
  include PublicActivity::Common
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { Photographer.first }#{ controller && controller.current_user }

  after_create :after_upload
  has_many :likes
  belongs_to :client
	belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
  processors: [:watermark],
  styles: lambda { |attachment| { 
      original: { geometry: "500x500", watermark_path: attachment.instance.watermark_url, position: "Center" },
      medium: "300x300#"
    }
  },
  url: ':s3_domain_url',
  path: '/:class/:attachment/:id_partition/:style/:filename',
  storage: :s3,
  s3_credentials: {
    :bucket =>            ENV['S3_BUCKET_NAME'],
    :access_key_id =>     ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
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

  def medium_image_url
    image.url(:medium)
  end

  def after_upload
    # if self.imageable_type == "Event"
    #   photographer = self.imageable.client.photographer
    # elsif self.imageable_type == "Album"
    #   photographer = self.imageable.photographer
    # end  
    # old_memory = photographer.memory_consumed
    # new_memory = self.image_file_size + old_memory
    # photographer.update_attributes(memory_consumed: new_memory)
  end

end
