class UsersController < ApplicationController
	def index
		@user = User.order(:email).search_user(params[:search])
		@users = User.all
	end
end
	