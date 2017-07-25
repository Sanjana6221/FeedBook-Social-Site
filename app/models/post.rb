class Post < ApplicationRecord
	# before_create :owner
	belongs_to :user
	has_many :pictures, as: :imageable

	validate :content_or_image

	enum privacy_type: {"All": "public", "friends": "friends", "me": "me"}
	mount_uploader :image, ImageUploader

	def content_or_image
		unless !content.blank? or !image.blank? 
      errors.add(:base, "Specify a charge or a payment, not both")
    end
	end
end
