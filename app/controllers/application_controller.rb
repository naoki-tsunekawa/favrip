class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper
	helper_method :current_user
	before_action :login_required

	private

	# def current_user
	# 	if session[:user_id]
  #     @current_user = User.find_by(id: session[:user_id])
  #   end
	# end

	def login_required
		# ユーザログイン済みかどうかチェック
		redirect_to login_url unless logged_in?
	end

end
