class Client < ActiveRecord::Base
  before_create :generate_authentication_token
  belongs_to    :photographer
  
  has_many   :events
  has_many   :images
  
  validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, presence: true
  validates :last_name,  format:  { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, presence: true
  validates :user_name,  format:   { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, presence: true 
  validates :email,      format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },uniqueness: true, presence: true
  validates :password, :confirmation => true, uniqueness: true
  validates_length_of :password, :in => 8..100

 def generate_authentication_token
   self.authentication_token = SecureRandom.hex
   self.password = Digest::SHA2.hexdigest(self.authentication_token + self.password) 
 end

end
