class Bookmark < ApplicationRecord
	belongs_to :user
  belongs_to :post
  self.per_page = 20
end
