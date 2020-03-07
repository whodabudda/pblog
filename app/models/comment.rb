class Comment < ApplicationRecord
  #belongs_to :commentable, polymorphic: false
  belongs_to :commentable_content, foreign_key: :commentable_id
  belongs_to :user
  has_many :comment_reviews

  #def commentable_type=(sType)
  #   super(sType.to_s.classify.constantize.base_class.to_s)
  #end

end
