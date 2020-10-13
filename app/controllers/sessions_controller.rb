class SessionsController < ApplicationController
  # ログイン画面はログインチェック処理をスキップする
  skip_before_action :login_required

  # ログイン機能
  def create
    # メールアドレスでユーザを検索する
    user = User.find_by(email: session_params[:email])
    # ユーザが見つかった場合はパスワードによる認証をUserモデルにhas_secure_passwordを記述した時に
    # 自動で追加された"authenticate"メソッドで行う
    if user&.authenticate(session_params[:password])
      # 認証ができた場合にセッションにuser_idを格納する
      log_in user
      # cookieにログイン情報を保存する
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ルートurlへredirect
      redirect_to root_path, notice: 'ログインしました。'
    else
      # 認証失敗した場合再度ログインページを表示
      render :new
    end
  end

  # ログアウト機能
  def destroy
    log_out if logged_in?
    # ルートページに遷移
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private
  # ストロングパラメータ
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
