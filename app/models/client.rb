class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :ensure_authentication_token
  acts_as_follower
  acts_as_followable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many      :photographer_clients  
  has_many      :photographers, through: :photographer_clients
  has_many      :events
  has_many      :images
  has_many      :likes

  has_attached_file :avatar, styles: { original: "500x500", medium: "300x300>"},
  :url  => "/system/avatar/images/000/000/00:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/avatar/images/000/000/00:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => {
    :bucket => 'gls-testing', 
    :access_key_id => 'AKIAJ2CZ275DJXIPIAEQ',
    :secret_access_key => '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' 
  }  
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  before_create :skip_confirmation if Rails.env.production?

  before_create :invited_client


  def skip_confirmation
    self.skip_confirmation!
  end

  def invited_client
    invited_clients = InviteClient.where(email: self.email)  
    if invited_clients
      invited_clients.map { |invited_client| self.photographer_clients.create( photographer_id: invited_client.photographer_id) }
    end
  end

	def generate_authentication_token
	  self.authentication_token = SecureRandom.hex
	  self.password = Digest::SHA2.hexdigest(self.authentication_token + self.password) 
	end
	
	def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token ||= generate_authentication_token
    end
  end   

  def get_followings
    activities = []
    follows_type = self.follows.pluck(:followable_type).uniq
    follows_type.each do |f|
      ids = self.follows.where("followable_type = ?", f).pluck(:followable_id).uniq
      activities += PublicActivity::Activity.where("owner_type = ? and owner_id in (?)",f, ids)
    end
    activities.sort_by(&:created_at).reverse
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Client.where(authentication_token: token).first
    end
  end  
end
