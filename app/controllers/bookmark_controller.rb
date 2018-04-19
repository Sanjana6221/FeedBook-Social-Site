class BookmarkController < ApplicationController

  def index
    @bookmarks = current_user.bookmarked_posts.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end

  def create
    post = Post.find(params[:post_id])
    bookmark = post.bookmarks.build(:user_id => current_user.id)
    if bookmark.save
      flash[:notice] = t('bookmark.save')
    else
      # bookmark.errors.full_messages
      # flash[:error] = t('bookmark.not_save')
      flash[:error] = bookmark.errors.full_messages
    end
    redirect_to posts_path
  end

  def destroy
    bookmark = Bookmark.where(params[:id]).first
    bookmark.destroy if bookmark.present?
    flash[:notice] = t('bookmark.remove')
    redirect_to posts_path
  end
end
