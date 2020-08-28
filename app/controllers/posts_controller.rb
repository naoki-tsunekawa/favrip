class PostsController < ApplicationController
  def index
    # 全ての投稿を取得　※一時的に
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      # 保存成功
      redirect_to posts_url, notice: "「#{@post.title}を投稿しました。」"
    else
      # 保存失敗
      # render :newで登録用のフォームに再び表示する。
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "投稿「#{post.title}」を更新しました。"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "タスク「#{post.title}」を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description , :image, :address)
  end
end
