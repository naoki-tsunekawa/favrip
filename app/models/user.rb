class User < ApplicationRecord
	#全て小文字で保存する。
	before_save { self.email = email.downcase }

	has_secure_password

	# emailアドレスの正規表現設定
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	# 画像投稿機能
	mount_uploader :image, ImageUploader

	# バリデーション設定
	validates :name, presence: true
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }

	# UserとPostに対して1対多の関係を定義
	has_many :posts
end
