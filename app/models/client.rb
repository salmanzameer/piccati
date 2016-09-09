class Client < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :ensure_authentication_token
  acts_as_follower
  acts_as_followable

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many      :photographer_clients  
  has_many      :photographers, through: :photographer_clients
  has_many      :events
  has_many      :images
  has_many      :likes
  belongs_to    :invitor, :class_name => 'Photographer', :foreign_key => 'invited_by_id'

  validates_format_of :email,:with => Devise::email_regexp
  validates :firstname, presence: true, format: { with: /\A[a-zA-Z_\s]+\z/, message: 'alphabets only' }
  validates :lastname, presence: true, format: { with: /\A[a-zA-Z_\s]+\z/, message: 'alphabets only' }
  validates :contnumber, presence: true, format: { with: /\A^(?:00|\+|0)?[1-9][[0-9]+[ \( \) \-]]*$\z/,  message: 'invalid'}
  validates :email, presence: true
  validates :terms_and_condition, presence: true, on: :create
  validates :password, presence: true
  validates_confirmation_of :password

  if Rails.env.production?
    has_attached_file :avatar, styles: { original: "500x500", medium: "300x300>"},
    default_url: 'user-avatar.png',
    url: ':s3_domain_url',
    path: '/:class/:attachment/:id_partition/:style/:filename',
    :storage => :s3,
    :s3_credentials => {
      :bucket =>            ENV['S3_BUCKET_NAME'],
      :access_key_id =>     ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  else
    has_attached_file :avatar, styles: { original: "500x500", medium: "300x300>" }, default_url: "user-avatar.png"  
  end
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
 
  after_create :invited_client

  def self.get_not_connected_clients(current_photographer)
    Client.joins("INNER JOIN photographer_clients on photographer_clients.client_id = clients.id")
    .select("clients.*")
    .where("(CASE WHEN clients.invited_by_id IS NULL THEN clients.invitation_accepted_at IS NULL ELSE clients.invitation_accepted_at IS NOT NULL END) AND photographer_clients.is_connected = false AND photographer_clients.photographer_id = #{current_photographer.id}")
  end

  def is_invited?(current_photographer)
    (invitor == current_photographer) && (invitation_accepted_at.blank?)
  end

  def invited_client
    if invitor.present?
      photographer_clients.create( photographer_id: invitor.id)
    end
  end

  def get_event_images
    Image.joins("inner join events on images.imageable_id = events.id")
    .joins("inner join clients on clients.id = events.client_id")
    .select("images.*")
    .where("clients.id = #{id} AND images.imageable_type = 'Event'")
  end

  def is_connected?(current_photographer)
    photographer_clients.where(photographer_id: current_photographer.id).first.is_connected
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

  def fullname
    "#{firstname} #{lastname}".titleize
  end

  def get_activity
    activities = []
    follows_type = self.follows.pluck(:followable_type).uniq
    follows_type.each do |f|
      ids = self.follows.where("followable_type = ?", f).pluck(:followable_id).uniq
      activities += PublicActivity::Activity.where("owner_type = ? and owner_id in (?)",f, ids)
    end
    activities.sort_by(&:created_at).reverse
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["email","firstname","lastname","contnumber"]
      all.each do |client|
        csv << client.attributes.values_at("email","firstname","lastname","contnumber")
      end
    end
  end

  def self.import(file,current_photographer)
    CSV.foreach(file.path, headers: true) do |row|
      client_hash = row.to_hash
      client =  Client.find_by_email(client_hash["email"])
      if client
        current_photographer.photographer_clients.where(client_id: client.id).first_or_create
      else
        Client.invite!(client_hash.merge!(skip_invitation: true))
      end
    end
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Client.where(authentication_token: token).first
    end
  end  
end
