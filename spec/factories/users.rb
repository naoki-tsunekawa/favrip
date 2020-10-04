FactoryBot.define do
  factory :user do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

# FactoryBot.define do
# 	# テストユーザ作成
# 	factory :user do
# 		name { 'テストユーザ' }
# 		email { 'test1@example.com' }
# 		password { 'highway' }
#     password_confirmation { 'highway' }
# 	end
# end
