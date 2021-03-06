class ProfileController < ApplicationController
  
  def show
		@user = User.find(params[:id])
		@posts = current_user.posts
	end

private
	def profile_params
	 	params.require(:user).permit(:firstname, :lastname,:email,:birth_date,:country,:language,:image)
  end
end
