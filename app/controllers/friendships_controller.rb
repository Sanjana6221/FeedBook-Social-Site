class FriendshipsController < ApplicationController
	
  def index
    @friend = Friendship.all
  end
	
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path
    else
      flash[:notice] = "Unable to add friend."
      redirect_to users_path
    end
  end

  def destroy
    potential_friend = User.find(params[:friend_id])
    friend_request = potential_friend.friendships.find(params[:id])

    friendship = current_user.friendships.find_by_friend_id(potential_friend.id)
    if friendship.nil?      #Users are not friends and you want to delete the friend request
      friend_request.destroy
      flash[:notice] = "Removed friend request."
    else                    #Users are friends and you want to delete the friendship
      friendship.destroy
      friend_request.destroy
      flash[:notice] = "Removed friendship."
    end
    redirect_to current_user
end

  
end
