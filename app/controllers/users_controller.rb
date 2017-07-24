class UsersController < ApplicationController
	def search
		@search_user = User.order(:email).search_user(params[:search])
		@users = User.all
	end
end
	