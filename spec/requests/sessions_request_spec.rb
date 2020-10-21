require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  # loginのテスト
  describe 'POST #create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(response).to redirect_to root_path
      # ログインしているかのテスト
      expect(is_logged_in?).to be_truthy
    end
  end

  # logoutのテスト
  describe 'DELETE #destroy' do
    it 'log out and redirect to root page' do
      delete logout_path(user)
      expect(response).to redirect_to root_path
      # ログインしていないことを確認
      # sessonの値がfalse
      expect(is_logged_in?).to be_falsey
    end
  end

  # remember_meチェックボックスのテスト
  context "login with remembering" do
    it "remembers cookies" do
      post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '1'} }
      expect(response.cookies['remember_token']).to_not eq nil
    end
  end

  context "login without remembering" do
    it "doesn't remember cookies"do
      # クッキーを保存してログイン
      post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '1'} }
      delete logout_path
      # クッキーを保存せずにログイン
      post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '0'} }
      expect(response.cookies['remember_token']).to eq nil
    end
  end
end
