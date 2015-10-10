class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]


  has_many :trips
  has_many :locations, through: :trips
  has_many :identities

  def self.from_omniauth(auth, signed_user = nil)
    Authenticator.new(signed_user, auth).user
    # identity  = Identity.find_for(auth)
    #
    # user = signed_user || identity.user
    #
    #
    # # first create identity
    # if user.nil?
    #   # check  user has use the same email register before
    #   user = User.where(email: auth.email).first if auth.email
    #   if user.nil?
    #     # no user use this email register before
    #     # create user for this identity
    #
    #     user = User.new(name: auth.user_name,
    #                     email: auth.email || "temp-#{auth.uid}@#{auth.provider}.com",
    #                     password: Devise.friendly_token[0,20])
    #
    #   end
    #
    #
    #   # Ideneity of user may be changed
    #   #
    #   if identity.user != user
    #     identity.user = user
    #     identity.save!
    #   end
    #
    # end
    #
    # user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def email_verified?
    true
  end
end
