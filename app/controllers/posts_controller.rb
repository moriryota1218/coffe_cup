class PostsController < ApplicationController

  before_action :authenticate_user!, :only =>[:new, :create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    # 「@post」の投稿した会員のid「user_id」の会員を「@user」で選択しています。
    # この「@user」の「family_name」「first_name」をページで表示させます。
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params.require(:post).permit(:user_id, :content, :place).merge(:user_id => current_user.id))
    @user = User.find(@post.user_id)
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    if @post.user_id == current_user.id
    else
      redirect_to "/posts"
      flash[:alert] = "無効なユーザー"
    end

  end

  def update
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  if @post.user_id == current_user.id
    @post.update(params.require(:post).permit(:content, :place))
  else
    redirect_to "/posts"
    flash[:alert] = "無効なユーザー"
  end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  if @post.user_id == current_user.id
    @post.destroy
  else
    redirect_to "/posts"
    flash[:alert] = "無効なユーザー"
  end
  end
end
