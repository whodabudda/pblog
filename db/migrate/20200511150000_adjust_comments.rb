class AdjustComments < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :reviewd_by, :string
    remove_column :comments, :commentscol, :string
    add_column :comments, :reviewed_by, :string
  end
end
