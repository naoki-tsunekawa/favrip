class Admin::UsersController < ApplicationController
  # ユーザ新規登録機能をログインしていなくても使用できる
  skip_before_action :login_required, only: %i[new create]
  # 管理者ユーザのみユーザのみ利用可能
  before_action :require_admin, only: %i[index destroy]
  # 別ユーザが編集しない
  before_action :set_user, only: %i[show edit]

  def index
    @users = User.all
  end

  def show
    # postsテーブルに保存されているログインしているユーザの投稿を取得
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # ユーザ新規作成後にroot_urlに遷移する
      log_in @user
      redirect_to root_url, notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path, notice: "ユーザー「#{@user.name}を更新しました。」"
    else
      # エラーメッセージを返すようにしてユーザにどこが間違っているか知らせるようにする。　2020/09/17
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # userに紐づいている投稿を削除する処理を作成する。
    redirect_to admin_user_path(@current_user), notice: "ユーザー「#{@user.name}を削除しました。」"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :description, :image)
  end

  # beforeアクション
  # adminユーザでない場合はユーザ一覧に遷移できないようにする。
  def require_admin
    redirect_to root_url unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end
