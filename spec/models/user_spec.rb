require 'rails_helper'

RSpec.describe User, type: :model do
  # バリデーションテスト
  describe 'validations presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  # emailのユニークテスト
  describe 'validate unqueness of email' do
    before do
      user_a = FactoryBot.create(:user, email: 'original@example.com')
    end

    # 同じemailアドレスを登録できないことを確認する。
    it 'is invalid with a duplicate email' do
      user = FactoryBot.build(:user, email: 'original@example.com')
      expect(user).to_not be_valid
    end

    # emailを空白の場合登録できないことを確認する。
    it 'is invalid with a blanck email' do
      user = FactoryBot.build(:user, email: ' ')
      expect(user).to_not be_valid
    end
  end

  # password バリデーションテスト
  describe 'validate presence of password' do

    # passwordを空白の場合登録できないことを確認する。
    it 'is invalid with a blanck password' do
      user = FactoryBot.build(:user, password: ' ')
      expect(user).to_not be_valid
    end

    it 'is at least 6 characters' do
      is_expected.to validate_length_of(:password).is_at_least(6)
    end

  end

end
