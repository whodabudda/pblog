class AddPublishDtToCommentableContents < ActiveRecord::Migration[6.0]
  def change
    add_column :commentable_contents, :pubish_dt, :datetime
    execute 'update commentable_contents c set c.publish_dt = c.updated_at'
  end
end
