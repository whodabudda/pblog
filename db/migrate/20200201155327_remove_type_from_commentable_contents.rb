class RemoveTypeFromCommentableContents < ActiveRecord::Migration[6.0]
  def change

    remove_column :commentable_contents, :type, :string
    remove_column :comments, :commentable_type, :string
  end
end
