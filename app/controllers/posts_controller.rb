class PostsController < ApplicationController
	
	def index
		@post = Post.new
		
		@friends_posts = Post.where(:user_id => current_user.all_friends) 

		@all_posts = @friends_posts.where(posts: {privacy_type: "friends" }) + current_user.posts + Post.all.where(posts: {privacy_type: "public"})

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
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	def edit
		@post = Post.find(params[:id])
		respond_to do |format|
   		format.js
		end
	end

	def update
		@post = Post.find(params[:id])
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
end
	