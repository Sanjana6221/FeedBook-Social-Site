class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:update,:destroy]
  
  def index
    @users = User.all
  end

  #Send a friendship request(add friend)
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = t('friendship.create')
    else
      flash[:notice] = t('friendship.create_error')
    end
    redirect_to friendships_path
  end

  # Only For friendship request (accept/reject)
  def update
    if params[:status] == 'accept'
      @friendship.accepted!      
      flash[:notice] = t('friendship.accept')
    elsif params[:status] == 'ignore'
      @friendship.rejected!
      flash[:notice] = t('friendship.ignore')
    end
    redirect_to friendships_path
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] =  t('friendship.remove')
    redirect_to friendships_path
  end

  private

  def set_friendship
    @friendship = Friendship.find_by_id(params[:id])
  end
end
