class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :destroy]
	def index
		@post = Post.new
		@friends_posts = Post.user_all_friends_post(current_user) 
		@all_posts = @friends_posts.friends_posts + current_user.posts + Post.all.all_posts
		@posts = @all_posts.sort_by(&:updated_at).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
      format.html 
      # format.json { render json: @posts}
      format.js 
  	end
  end
	
	def create
  	@post = current_user.posts.new post_params
   		if @post.save
      	flash[:notice] = "You have successfully created."
        redirect_to posts_path
      else
        flash[:notice] = "Post not created."
        redirect_to posts_path
      end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	def edit
		respond_to do |format|
   		format.js
		end
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
      render 'form'
    end
	end

 private
		def post_params
		 	params.require(:post).permit(:content, :image,:privacy_type)
	  end

	  def set_post
      @post = Post.find(params[:id])
    end
end
	

	