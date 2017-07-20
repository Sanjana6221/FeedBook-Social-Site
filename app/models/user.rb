class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts,dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  serialize :language

  ALLOWED_LANGUAGES = ["Hindi", "English", "Other"]

  def self.search_user(search)
    if search.present?
      @user = User.find_by(email: search)
    end
  end
end

