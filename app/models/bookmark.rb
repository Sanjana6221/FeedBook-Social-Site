class Bookmark < ApplicationRecord
	belongs_to :user
  belongs_to :post
  validates :user_id, presence: { message: "must be given" }
  validates :post_id, presence: { message: "should be select to bookmarked" }
  self.per_page = 20
end
