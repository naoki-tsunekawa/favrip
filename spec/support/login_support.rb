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
end
