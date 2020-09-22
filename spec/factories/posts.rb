FactoryBot.define do

	factory :post do
		title { 'テスト投稿' }
		description { 'RSpec&Capybara&FactoryBotを準備する' }
		association :user, factory: :user
	end
end
