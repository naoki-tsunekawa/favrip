FactoryBot.define do
	# テストユーザ作成
	factory :user do
		name { 'テストユーザ' }
		email { 'test1@example.com' }
		password { 'highway' }
	end
end
