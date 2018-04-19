Person = Struct.new(:name, :address)

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  CONSTANT_ARRAY = [0,1,2,3]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:omniauthable, :omniauth_providers => [:facebook,:twitter,:google_oauth2]
  delegate :test_user3, to: :class
  has_many :posts,dependent: :destroy
  has_one :picture, as: :imageable
  
  has_many :bookmarks#, through: :posts
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  
  mount_uploader :image, ImageUploader
  has_many :friendships

  has_many :pending_friends, -> {where(friendships: {status: "pending"})},
            :through => :friendships,
            :source => :friend
  
  has_many :friends, -> { where(friendships: {status: "accepted"}) }, 
            through: :friendships

  has_many :rejected_friends, -> {where(friendships: {status: "rejected"})},
            :through => :friendships,
            :source => :friend
                
  has_many :pending_friends, -> {where(friendships: {status: "pending"})},
            :through => :friendships,
            :source => :friend

  has_many :inverse_friendships, :class_name => "Friendship",
           :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_one :facebook_oauth_setting

  serialize :language

  ALLOWED_LANGUAGES = ["Hindi", "English", "Other"]
  
  def test_user
    "in model user method first"
  end

  def test_user2
    "in model user method second"
  end

  def self.test_user3
    "test user 3"
  end

  def self.search_user(search)
    if search.present?
      @user = User.find_by(email: search)
    end
  end

  def is_mutual_friend_with?(user)
    friendships.exists?(friend_id: user.id) || inverse_friendships.exists?(user_id: user.id)
  end 

  def get_mutual_friendship_with(user)
    mutual_friendship = friendships.where(friend_id: user.id).first
    mutual_friendship ||= inverse_friendships.where(user_id: user.id).first
    mutual_friendship
  end

  def all_friends
    friends + inverse_friends
  end

  def self.from_omniauth(auth)
    data = auth.info
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.name  
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        if auth.info.try(:email)
          user.email = auth.info.email
          user.save
        else
          user.email = auth.uid.to_s+"@facebook.com"
          user.save
        end
      user.skip_confirmation!
    end
  end

  def self.for_twitter_omniauth(auth)
    data = auth.info
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.emails = auth.uid.to_s+"@twitter.com"
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.nickname   
      user.image = auth.info.image 
      user.skip_confirmation!
    end
  end
end
      
