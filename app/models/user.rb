class User < ApplicationRecord
	has_secure_password

	# 画像投稿機能
	mount_uploader :image, ImageUploader

	# バリデーション設定
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }

	# UserとPostに対して1対多の関係を定義
	has_many :posts
end
