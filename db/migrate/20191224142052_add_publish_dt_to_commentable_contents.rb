class AddPublishDtToCommentableContents < ActiveRecord::Migration[6.0]
  def change
    add_column :commentable_contents, :pubish_dt, :datetime
  end
end
