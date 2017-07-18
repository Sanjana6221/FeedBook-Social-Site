class PostsController < ApplicationController
	
	def index
		@post = Post.new
		@posts = Post.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    Post.order(updated_at:"DESC")
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

		def show
			@user = User.find(params[:id])
			Post.order(created_at:"DESC")
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