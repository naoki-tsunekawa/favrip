class User < ApplicationRecord
	has_secure_password
	# バリデーション設定
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	# UserとPostに対して1対多の関係を定義
	has_many :posts
end
