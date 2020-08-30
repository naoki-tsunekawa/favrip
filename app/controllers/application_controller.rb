class ApplicationController < ActionController::Base
	helper_method :current_user
	before_action :login_required

	private

	def current_user
		if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end
	end

	def login_required
		# ユーザログイン済みかどうかチェック
		redirect_to login_url unless current_user
	end

end
