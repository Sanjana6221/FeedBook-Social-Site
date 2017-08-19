class Post < ApplicationRecord 
	belongs_to :user
	has_many :pictures, as: :imageable
	has_many :bookmarks, dependent: :destroy
	validate :content_or_image	
	enum privacy_type: {"All": "public", "friends": "friends", "me": "me"}
	mount_uploader :image, ImageUploader
	self.per_page = 5
	
	scope :user_all_friends_post, lambda { |user| 
		where(:user_id => user.all_friends) }
	scope :friends_posts, -> { where(posts: {privacy_type: "friends" }) }
	scope :all_posts, -> { where(posts: {privacy_type: "public" }) }
	
	def content_or_image
		unless !content.blank? or !image.blank? 
      errors.add(:base, "Specify a charge or a payment, not both")
    end
	end
	def timestamp
	  created_at.try(:strftime,'%d %B %Y %H:%M:%S')
	end
end

