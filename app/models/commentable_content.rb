class CommentableContent < ApplicationRecord
	mount_uploader :picture, PictureUploader
	has_many :comments, as: :commentable


end
