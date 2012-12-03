class AddReceiveNewsletterToUsers < ActiveRecord::Migration
        def change
            add_column :users, :receive_newsletter, :boolean
        end
        
        def down
            remove_column :users, :receive_newsletter
        end
end
