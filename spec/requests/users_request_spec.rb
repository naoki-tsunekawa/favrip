require 'rails_helper'

RSpec.describe "Users", type: :request, js: true do
	# 変数宣言
	let(:test_user) { FactoryBot.create(:user) }

	# ユーザ新規登録画面へのレスポンステスト
	describe "GET /signup" do
		it "responds successfully" do
      get sign_up_path
      expect(response).to have_http_status 200
    end
	end

	# ユーザ新規登録した後のレスポンステスト
	describe 'create' do
    context 'valid request' do
      it 'adds a user' do
        expect do
					post sign_up_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      context 'adds a user' do
        before { post sign_up_path, params: { user: FactoryBot.attributes_for(:user) } }
        subject { response }
        it { is_expected.to redirect_to root_url }
        it { is_expected.to have_http_status 302 }
        it 'log in' do
          expect(is_logged_in?).to be_truthy
        end
      end
    end
	end

	# ユーザの編集画面のレスポンステスト
	# edit action
  describe 'edit' do
    context 'valid request' do
      # 認可されたユーザーとして
      it "responds successfully" do
        sign_in_as test_user
        get edit_admin_user_path(test_user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      # ログインしていないユーザーの場合
      context "as a guest" do
        # ログイン画面にリダイレクトすること
        it "redirects to the login page" do
          # loginせずに編集ページに遷移せずにログインページに遷移することを確認
          sign_out_as test_user
          get edit_admin_user_path(test_user)
          expect(response).to have_http_status 302
          expect(response).to redirect_to login_path
        end
      end

    end
  end


end
