class BookmarkController < ApplicationController

	def index
		@bookmarks = current_user.bookmarked_posts.paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
	end

	def create
		@post = Post.find(params[:post_id])
    @bookmark = @post.bookmarks.build(:user_id => current_user.id)
		if @bookmark.save
      flash[:notice] = "Saved as Bookmark."
       redirect_to posts_path
     else
      flash[:error] = "not saved"
      redirect_to posts_path
    end
	end
	
	def destroy
		@post = Post.find(params[:id])
		@bookmark = Bookmark.where(post_id: @post, user_id: current_user)	.first
		if @bookmark.destroy
			flash[:notice] = "Removed from bookmark"
			redirect_to posts_path
		else
			flash[:error] = "Unable to remove"
			redirect_to posts_path
		end
	end
end
