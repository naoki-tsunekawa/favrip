class PostsController < ApplicationController
  def index
    # 全ての投稿を取得　※一時的に
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to posts_url, notice: "「#{post.title}を投稿しました。」"
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :description , :image, :address)
  end


end
