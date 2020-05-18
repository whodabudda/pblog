class AddAliasToAdmins < ActiveRecord::Migration[5.0]
  def change
 	add_column :admins, :alias, :string
  end
end

