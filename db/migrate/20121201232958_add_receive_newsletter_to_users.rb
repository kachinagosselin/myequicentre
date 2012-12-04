class AddReceiveNewsletterToUsers < ActiveRecord::Migration
        def change
            add_column :users, :receive_newsletter, :boolean
            User.update_all ["receive_newsletter = ?", true]
        end
        
        def down
            remove_column :users, :receive_newsletter
        end
end
