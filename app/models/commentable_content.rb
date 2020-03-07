class CommentableContent < ApplicationRecord
	validate :publish_dt_cannot_be_in_the_past
	mount_uploader :picture, PictureUploader
	#has_many :comments, as: :commentable
	has_many :comments, foreign_key: :commentable_id

  def publish_dt_cannot_be_in_the_past
    if publish_dt.present? && publish_dt_will_change! && publish_dt < Date.today - 15.minutes
      errors.add(:publish_dt, "can't be in the past. Update the publish date or remove it")
    end
  end

end
