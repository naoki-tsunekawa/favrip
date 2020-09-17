class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit]

  def index
    # 全ての投稿を取得　※一時的に
    # posts = Post.all
    # 検索機能
    @search = Post.ransack(params[:q])
    @posts = @search.result
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.new(post_params)

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
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      redirect_to posts_url, notice: "投稿「#{post.title}」を更新しました。"
    else
      # バリデーションの設定をする　2020/09/17
      render :edit
    end
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

  def set_post
    @post = Post.find(params[:id])
  end

end
