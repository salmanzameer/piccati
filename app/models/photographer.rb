class Photographer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :ensure_authentication_token
  acts_as_followable
  
  has_many    :clients
  has_many    :events, through: :clients   
  belongs_to  :package
  has_many    :achievements
  has_many    :albums

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  
  has_attached_file :avatar, styles: { original: "500x500", medium: "300x300>"},
  :default_url => "user-avatar.png",
  :url  => "/system/avatar/images/000/000/00:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/avatar/images/000/000/00:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => {
    :bucket => 'gls-testing', 
    :access_key_id => 'AKIAJ2CZ275DJXIPIAEQ',
    :secret_access_key => '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' 
  }
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_attached_file :watermark_logo, styles: { original: "500x500"},
  :url  => "/system/watermark_logo/images/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/watermark_logo/images/:id/:style/:basename.:extension",
  :storage => :s3,
  :s3_credentials => {
    :bucket => 'gls-testing', 
    :access_key_id => 'AKIAJ2CZ275DJXIPIAEQ',
    :secret_access_key => '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' 
  }  
  validates_attachment_size :watermark_logo, :less_than => 5.megabytes
  validates_attachment_content_type :watermark_logo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  accepts_nested_attributes_for :achievements, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  before_create :skip_confirmation if Rails.env.production?

  def skip_confirmation
    self.skip_confirmation!
  end
  
  class << self
    def current_photographer=(photographer)
      Thread.current[:current_photographer] = photographer
    end

    def current_photographer
      Thread.current[:current_photographer]
    end
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
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Photographer.where(authentication_token: token).first
    end
  end
end
