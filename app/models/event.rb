class Event < ActiveRecord::Base
   
	belongs_to :client
	has_many :images
	 

   # mount_uploaders :attachment, AttachmentUploader 
   # validates :name, presence: true 
end
