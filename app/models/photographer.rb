class Photographer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :firstname, use: [:slugged, :finders]


  include PublicActivity::Common
  after_create :set_default_plan
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :ensure_authentication_token
  acts_as_followable
  acts_as_follower

  has_many    :photographer_clients, dependent: :delete_all
  has_many    :packages, dependent: :delete_all
  has_many    :clients, through: :photographer_clients
  has_many    :events
  has_many    :photographer_plans, dependent: :delete_all
  has_one     :plan, through: :photographer_plans
  has_many    :achievements
  has_many    :albums, dependent: :destroy
  has_many    :invite_clients, dependent: :delete_all
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  validates :firstname, presence: true, format: { with: /\A[a-zA-Z_\s]+\z/, message: 'alphabets only' } # as studio name
  # validates_format_of :lastname, :with => /\A[a-zA-Z_\s]+\z/, message: 'alphabets only'
  validates :contnumber, presence: true, format: { with: /\A^(?:00|\+|0)?[1-9][[0-9]+[ \( \) \-]]*$\z/,  message: 'invalid contact'}
  validates :terms_and_condition, presence: true, on: :create
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates_confirmation_of :password, on: :create

  ProfileContributions = {studioname: 15, email: 15, contactnumber: 15, package: 15, avatar: 20, feature_image: 20}
  if Rails.env.production?
    has_attached_file :avatar, styles: { original: "500x500", medium: "300x300>"},
    :default_url => "user-avatar.png",
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
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  if Rails.env.production?
    has_attached_file :watermark_logo, styles: { original: "500x500"},
    url: ':s3_domain_url',
    path: '/:class/:attachment/:id_partition/:style/:filename',
    :storage => :s3,
    :s3_credentials => {
      :bucket =>            ENV['S3_BUCKET_NAME'],
      :access_key_id =>     ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }  
  else
    has_attached_file :watermark_logo, styles: { original: "500x500", medium: "300x300>" }, default_url: "user-avatar.png"  
  end

  validates_attachment_size :watermark_logo, :less_than => 5.megabytes
  validates_attachment_content_type :watermark_logo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  if Rails.env.production?
    has_attached_file :feature_image, styles: { original: "500x500", medium: "300x300>"},
    :default_url => "user-avatar.png",
    url: ':s3_domain_url',
    path: '/:class/:attachment/:id_partition/:style/:filename',
    :storage => :s3,
    :s3_credentials => {
      :bucket =>            ENV['S3_BUCKET_NAME'],
      :access_key_id =>     ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  else
    has_attached_file :feature_image, styles: { original: "500x500", medium: "300x300>" }, default_url: "user-avatar.png"  
  end
  validates_attachment_size :feature_image, :less_than => 5.megabytes
  validates_attachment_content_type :feature_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  accepts_nested_attributes_for :achievements, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  before_create :set_role_type, :set_connects

  def decrement_invitation_limit!
    true  
  end

  def set_role_type
    self.role_type = "Studio"
  end

  def set_default_plan
    photographer_plans.create(status: PhotographerPlan::Status::ACTIVE, expired_at: DateTime.now + 15.days, plan_id: Plan.default.id)
    update(plan_type: Plan.default.name, expired_at: DateTime.now + 15.days)
  end

  def memory_available?(size)
    memory = photographer_plans.active_plan? ? photographer_plans.active.plan.storage : 5
    ((memory_consumed + size.to_f)/(1024*1024)) <= memory
  end

  def memory_refactor(size)
    update_attributes(memory_consumed: (memory_consumed - size))
  end

  class << self
    def current_photographer=(photographer)
      Thread.current[:current_photographer] = photographer
    end

    def current_photographer
      Thread.current[:current_photographer]
    end
  end

  def get_activity
    activities = PublicActivity::Activity.where(recipient_type: self.class.to_s,recipient_id: self.id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |photographer|
      photographer.email = auth.uid+"@facebook.com"
      photographer.password = Devise.friendly_token[0,20]
      photographer.firstname = auth.info.name   
    end
  end

  def self.new_with_session(params, session)
      super.tap do |photographer|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          photographer.email = data["email"] if photographer.email.blank?
        end
      end
  end

  def fullname
    "#{firstname}".titleize
  end

  def album_featured_image_url
    if self.feature_image.present?
      self.feature_image.url
    elsif self.albums.present?
      self.albums.first.images.first.image.url if self.albums.first.images.present?
    end
  end

  def images_likes_count
    count = 0
    self.albums.each do |album|
      album.images.each do |image|
        count += image.likes_count
      end
    end
    count
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token ||= generate_authentication_token
    end
  end   

  private

  def set_connects
    total_connects = 1
    used_connects =  0
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Photographer.where(authentication_token: token).first
    end
  end
end
