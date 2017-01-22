class CreateComment < ActiveRecord::Migration[5.0]
  def change
       create_table(:comment) do |t|
      ## Database authenticatable
      t.string :comment, null: false, :limit => 2000
      t.references :commentable , polymorphic: true, index: true
      t.references :user
      t.timestamps null: false
     end

  end
end
