class FriendshipsController < ApplicationController
  # before_action :set_friendship, except: [:index, :create]
  before_action :set_friendship, only: [:update,:destroy]

  def index
    @users = User.all
  end

  #Send a friendship request(add friend)
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to friendships_path
    else
      flash[:notice] = "Unable to add friend."
      redirect_to friendships_path
    end
  end

  # Only For friendship request (accept/reject)
  def update
    if params[:status] == 'accept'
      @friendship.accepted!      
      flash[:notice] = "friend requested accepted #{@friendship.user.email}"
    elsif params[:status] == 'ignore'
      @friendship.rejected!
      flash[:notice] = "The friend request was successfully rejected."
    end

    redirect_to  friendships_path
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end

  def fb_friends
    @user_fb_token = current_user.facebook_access_token
    unless @user_fb_token.blank?
      @fb_friends = FbGraph::User.me(@user_fb_token.access_token).friends
      @fb_friends = @fb_friends.sort_by { |fb_frnd| fb_frnd.raw_attributes['name']}
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find_by_id(params[:id])
  end
end
