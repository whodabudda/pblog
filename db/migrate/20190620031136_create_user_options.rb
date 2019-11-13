class CreateUserOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_options do |t|
      t.references :user, foreign_key: true, type: :int
      t.boolean :email
      t.boolean :sms
      t.boolean :notification
      t.text :subscription

      t.timestamps
    end
  end
end


# CREATE TABLE `user_options` (`id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY, 
# `user_id` int(11), 
# `email` tinyint(1), 
# `sms` tinyint(1), 
# `notification` tinyint(1), 
# `subscription` text, 
# `created_at` datetime NOT NULL, 
# `updated_at` datetime NOT NULL,  
# INDEX `index_user_options_on_user_id`  (`user_id`), 
# CONSTRAINT `fk_rails_8197038674`
# FOREIGN KEY (`user_id`)
#   REFERENCES `users` (`id`)
#   )
