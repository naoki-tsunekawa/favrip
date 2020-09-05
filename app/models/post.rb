class Post < ApplicationRecord
	mount_uploader :image, ImageUploader

	validates :title, presence: true

	# UserとPostに対して1対多の関係を定義
	belongs_to :user
end
