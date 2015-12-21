class Photographer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
            validates :title ,    inclusion: { within: %w(Mr Miss Mrs Dr)}
            validates :title,     presence: true
            validates :firstname, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :lastname,  format:  { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :username,  format:   { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :contnumber,format:{:with => /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/}
            has_many :clients
              
             
      end
