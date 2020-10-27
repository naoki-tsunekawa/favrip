class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper
	helper_method :current_user
	before_action :login_required

	private

	def login_required
		# ユーザログイン済みかどうかチェック
		redirect_to login_url unless logged_in?
	end

end
