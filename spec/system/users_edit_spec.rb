require 'rails_helper'

RSpec.describe 'UsersEdits', type: :system, js: true do
  # 変数宣言
  let!(:user) { FactoryBot.create(:user, email: 'edituser@example.com') }

  # ユーザの編集に成功する
  describe 'user edit account' do
    context 'successful edit' do
			before do
				valid_login user
      end

			it 'successful user edit' do
				# edit pathに遷移する。
				visit edit_admin_user_path(user)

        # 編集画面でユーザ情報を編集
        fill_in 'user_name', with: 'EditTestUser'
				fill_in 'user_description', with: 'Hello, My name is Test User'

        click_button "登録する"
        expect(current_path).to eq admin_user_path(user)
        expect(user.reload.name).to eq "EditTestUser"
      end
    end
  end
end
