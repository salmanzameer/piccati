class Client < ActiveRecord::Base
      
	      validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :last_name,  format:  { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :user_name,  format:   { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
            validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
            validates :password, :confirmation => true
            validates_length_of :password, :in => 6..20
            #validates :contnumber,format:{:with => /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/}
            belongs_to :photographer
            has_many :events
            #scope :sorted , lambda {order("clients.position ASC")}
            
end
