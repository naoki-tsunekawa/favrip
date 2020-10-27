# loginモジュール
module LoginSupport
	# login method
  def valid_login(user)
		visit login_path
		fill_in 'session_email', with: user.email
		fill_in 'session_password', with: user.password
		click_button 'ログイン'
	end

	# session check method
	def is_logged_in?
    !session[:user_id].nil?
	end

	# ログイン処理
	def sign_in_as(user)
		post login_path, params: { session: { email: user.email,
																				password: user.password } }
	end

	# ログアウト処理
	def sign_out_as(user)
		delete logout_path
	end

end
