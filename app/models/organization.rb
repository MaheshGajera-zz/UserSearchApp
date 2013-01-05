class Organization < ActiveRecord::Base
  	attr_accessible :address1, :address2, :city, :country, :email, :name, :phone, :zip

  	validates :name, presence: true, length: { maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    
    VALID_ADDR_REGEX = /[\w+\s*\-.\,\/\\]+/i
	validates :address1, presence: true, format: { with: VALID_ADDR_REGEX }
	validates :address2, format: { with: VALID_ADDR_REGEX }
	
	VALID_CITY_REGEX = /[\w+\s*\-]+/i
	validates :city, presence: true, format: { with: VALID_CITY_REGEX }
	validates :country, presence: true, format: { with: VALID_CITY_REGEX }

	VALID_PHONE_REGEX = /[0-9\s*\-\+]+/i
	validates :phone, format: { with: VALID_PHONE_REGEX }, length: { maximum: 15 }

	VALID_ZIP_REGEX = /[0-9a-zA-Z]+/i
	validates :zip, presence: true, format: { with: VALID_ZIP_REGEX }, length: { maximum: 10 }
end
