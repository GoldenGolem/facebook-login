class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  def self.new_with_session(params, session)
	  super.tap do |user|
	    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	      user.email = data["email"] if user.email.blank?
	      user.location = data['location']['name'] if user.location.blank?  
	    end
	  end
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	    user.location = auth.extra.raw_info.email
	    user.birthday = auth.extra.raw_info.gender
	  end
	end

	def self.from_phone(name, number)
		where(name: name).first_or_create do |user|
			user.name = name
			user.phone_num = number
	    	user.password = Devise.friendly_token[0,20]
	    	user.email = number+'@test.com'
		end
	end
end
