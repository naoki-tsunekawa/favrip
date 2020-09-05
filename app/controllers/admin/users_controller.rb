class Admin::UsersController < ApplicationController
  # ユーザ新規登録機能をログインしていなくても
  skip_before_action :login_required, only: %i[new create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # postsテーブルに保存されているログインしているユーザの投稿を取得
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)


    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(user_params[:id])

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}を更新しました。」"
    else
      redirect :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_url, notice: "ユーザー「#{@user.name}を削除しました。」"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

end
