class CreateRogue < ActiveRecord::Migration[5.0]
  def change
       create_table(:rogues) do |t|
      ## Database authenticatable
      t.string :picture             
      t.string :title, null: false, default: "untitled",:limit => 255
      t.string :extract, :limit => 2000
      t.binary :bio 
      t.references :created_by
      t.references :modified_by
      t.timestamps null: false
     end

  end
end
