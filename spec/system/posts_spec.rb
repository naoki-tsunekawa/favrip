require 'rails_helper'

describe '投稿管理機能', type: :system, js: true do

	describe '一覧表示機能' do
		before do
			#ユーザAを作成しておく
			user_a = FactoryBot.create(:user, name: 'ユーザA', email: 'test1@example.com')
			# 作成者がユーザAであるタスクを作成しておく
			FactoryBot.create(:post, title: '最初のタスク', user: user_a)
		end

		context 'ユーザAがログインしている時' do

			before do
				# ユーザAでログインする
				visit login_path
				fill_in 'session_email', with: 'test1@example.com'
				fill_in 'session_password', with: 'highway'
				# click_button 'ログイン'
				click_button 'ログイン'
			end

			it 'ユーザAが作成したタスクが表示される' do
				# 作成済みのタスクの名称が画面上に表示されているとこを確認
				expect(page).to have_content '最初のタスク'
			end

		end


	end
end
