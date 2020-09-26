require 'rails_helper'

RSpec.describe "SiteLayoutTests 'favrip' ", type: :system do
  #　未ログイン時root_pathテスト
  context 'access to root_path' do
    before { visit root_path}
    # subject { page }
    it 'has links sach as login and sign_up path' do
      # ログイン画面へのURL
      expect(page).to have_link 'ログイン', href: login_path
      # is_expected.to have_link 'ログイン', href: login_path
      # 新規登録画面へのURL
      expect(page).to have_link '新規登録', href: sign_up_path
      # is_expected.to have_link '新規登録', href: sign_up_path
    end
  end

end
