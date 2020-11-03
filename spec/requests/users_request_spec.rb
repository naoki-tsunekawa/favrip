require 'rails_helper'

RSpec.describe "Users", type: :request, js: true do
	# 変数宣言
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true)}
  let(:other_user) { FactoryBot.create(:user, email: 'otheruser@example.com') }
  let(:admin_params) { FactoryBot.attributes_for(:user, admin: true) }

	# ユーザ新規登録画面へのレスポンステスト
	describe "GET /signup" do
		it "responds successfully" do
      get sign_up_path
      expect(response).to have_http_status 200
    end
	end

	# ユーザ新規登録テスト
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

	# ユーザの編集テスト
  describe 'edit' do
    context 'valid request' do
      # 認可されたユーザーとして
      it "responds successfully" do
        sign_in_as user
        get edit_admin_user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      # ログインしていないユーザーの場合
      context "as a guest" do
        # ログイン画面にリダイレクトすること
        it "redirects to the login page" do
          # loginせずに編集ページに遷移せずにログインページに遷移することを確認
          sign_out_as user
          get edit_admin_user_path(user)
          expect(response).to have_http_status 302
          expect(response).to redirect_to login_path
        end
      end

    end
  end

  # admin属性変更禁止テスト
  describe 'admin' do
    # web経由で変更できないこと
    it 'should not allow the admin attribute to be edited via the web' do
      patch admin_user_path(user), params: { user: admin_params }
      # DBに保存されたuserのadminの値がtrueではないことを確認
      expect(user.reload).to_not be_admin
    end
  end

  # ユーザ削除テスト
  describe 'delete' do
    before do
      # 削除データの為のユーザを作成
      user
    end
    # 管理者ユーザの場合としてユーザを削除できること
    context "as an authorized user" do
      # ユーザ削除できること
      it "deletes a user" do
        sign_in_as admin_user
        expect {
          delete admin_user_path(user), params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end

    # 管理者ユーザではないユーザの場合
    context "as au unauthorized user" do
      # ユーザ削除できないこと
      it "redirects to the dashboard" do
        sign_in_as other_user
        expect {
          delete admin_user_path(user), params: { id: user.id }
        }.to change(User, :count).by(0)
      end
    end
  end


end
