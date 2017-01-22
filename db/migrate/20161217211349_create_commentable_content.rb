class CreateCommentableContent < ActiveRecord::Migration[5.0]
  def change
       create_table(:commentable_content) do |t|
      ## Database authenticatable
      t.string :picture             
      t.string :title, null: false, default: "untitled",:limit => 255
      t.string :extract, :limit => 2000
      t.binary :content 
      t.references :commentable
      t.references :created_by , references: :admin
      t.references :modified_by , references: :admin
      t.string :type
      t.timestamps null: false
     end

  end
end
  