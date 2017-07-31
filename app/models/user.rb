class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts,dependent: :destroy
  has_one :picture, as: :imageable
  
  has_many :bookmarks
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
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:omniauthable, :omniauth_providers => [:facebook]

  serialize :language

  enum languages:  [:Hindi, :English, :Other]

  def self.search_user(search)
    if search.present?
      @user = User.find_by(email: search)
    end
  end

  def is_mutual_friend_with?(user)
    friendships.exists?(friend_id: user.id) || inverse_friendships.exists?(user_id: user.id)
  end 

  def sent_request_to?(user)
    potential_friend = User.find(params[:friend_id])
    friend_request = potential_friend.friendships.find(params[:id])

    friendship = current_user.friendships.find_by_friend_id(potential_friend.id)
    if friendship.nil?      #Users are not friends and you want to delete the friend request
      friend_request.destroy
      flash[:notice] = "Removed friend request."
    end
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
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end