class UsersController < ApplicationController
	def index
	  @users = User.order(:email).where("email like ?", "%#{params[:term]}%")
	  render json: @users.map(&:email)
end
end
