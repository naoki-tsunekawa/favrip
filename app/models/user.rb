class User < ApplicationRecord
	has_secure_password
	# バリデーション設定
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
end
