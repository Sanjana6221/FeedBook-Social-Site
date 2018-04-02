class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @post = Post.new
  end

  def index
    friends_posts = Post.user_all_friends_post(current_user) 
    all_posts = friends_posts.friends_posts + current_user.posts + Post.all.all_posts
    @posts = all_posts.sort_by(&:updated_at).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html 
      format.json
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = t('post.create')
    else
      flash[:notice] =  t('post.create_error')
    end
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    flash[:notice] = t('post.delete')
    redirect_to posts_path
  end

  def update
    @post.update_attributes(post_params)
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:content, :image,:privacy_type)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end


