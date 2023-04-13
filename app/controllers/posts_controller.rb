class PostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @comment = Comment.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find_by_id(params[:id])
    @comments = @post.comments
    @like = Like.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path notice: 'Post created successfully'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])

    authorize! :destroy, @post

    if @post.destroy
      flash[:success] = 'Post deleted successfully.'
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = 'Failed to delete post.'
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

