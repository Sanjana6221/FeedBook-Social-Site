class Post < ApplicationRecord
	# before_create :owner
	belongs_to :user
	has_many :pictures, as: :imageable
	has_many :bookmarks
	
	validate :content_or_image

	enum privacy_type: {"All": "public", "friends": "friends", "me": "me"}
	mount_uploader :image, ImageUploader

	self.per_page = 5
	
	def content_or_image
		unless !content.blank? or !image.blank? 
      errors.add(:base, "Specify a charge or a payment, not both")
    end
	end

	# def friends_posts
 #    self.where(:user_id => current_user.all_friends) 
 #  end
	def timestamp
	  created_at.try(:strftime,'%d %B %Y %H:%M:%S')
	end
	
end
