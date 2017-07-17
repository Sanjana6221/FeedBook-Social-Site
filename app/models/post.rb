class Post < ApplicationRecord
	# before_create :owner
	belongs_to :user

	enum privacy_type: {"All": "public", "friends": "friends", "me": "me"}
	mount_uploader :image, ImageUploader

	# enum designation: {"director": "director", "hr": "hr"}
   
   # def owner
   # 	 self.user_id = current_user.id
   # end

end
